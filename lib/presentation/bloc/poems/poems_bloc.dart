import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:nevesomiy/data/data.dart';
import 'package:nevesomiy/domain/domain.dart';
import 'package:nevesomiy/domain/entites/ettities.dart';

part 'poems_event.dart';
part 'poems_state.dart';

class PoemsBloc extends Bloc<PoemsEvent, PoemsState> {
  final CacheService cacheService;
  final PoemsUseCase poemsUseCase;

  PoemsBloc():
      cacheService = CacheService.instance,
      poemsUseCase = PoemsUseCase.instance,
      super(PoemsLoading()) {
    on<PoemsEvent>(_onEvent);
  }


  Future<void>? _onEvent(
    PoemsEvent event,
    Emitter<PoemsState> emit,
  ) {
    if (event is PoemsLoad) return _onLoad(event, emit);
    if (event is PoemsLoadAndListen) return _onLoadRemoteAndListen(event, emit);
    if (event is PoemsSortByType) return _onSort(event, emit);
    return null;
  }


  Future<void> _onLoad(PoemsLoad event, Emitter<PoemsState> emit) async {
    final topic = await cacheService.getTopicName();

    if (event.syncWithFireStore) {
      final result = await poemsUseCase.doRemotePoems();
      result.fold(
        (falure) => emit(PoemsError(error: falure.message)),
        (right) {log('REMOTE SIMPLE');});
    } else {
      log('LOCAL SIMPLE');
      await poemsUseCase.doLocalPoems();
    }
    emit(PoemsLoaded(
      poems: poemsUseCase.poemsSortedBy(topic),   //poemsUseCase.poemsRepository.poems, 
      value: topic, 
    ));
  }

  Future<void> _onLoadRemoteAndListen(PoemsLoadAndListen event, Emitter<PoemsState> emit) async {
    final topic = await cacheService.getTopicName();
    await emit.forEach<QuerySnapshot<Object?>>(
      poemsUseCase.poemsStream,
      onData: (data) { 
        final poems = poemsUseCase.doRemotePoemsAndListen(data);
        log('REMOTE ONLISTEN ${poems.length}');
        return PoemsLoaded(
          poems: poemsUseCase.poemsSortedBy(topic),
          value: topic,
        );
      },
      onError: (error, stackTrace) => PoemsError(error: error),
    );
  }


  Future<void> _onSort(PoemsSortByType event, Emitter<PoemsState> emit) async {
    emit(PoemsLoading());
    await cacheService.saveTopicName(event.value.name);
    emit(PoemsLoaded(
      poems: poemsUseCase.poemsSortedBy(event.value), 
      value: event.value, 
    ));
  }
}
