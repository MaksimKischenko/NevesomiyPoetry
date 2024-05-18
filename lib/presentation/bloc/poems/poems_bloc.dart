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
    if (event is PoemsLoadAndListen) return _onLoadRemoteAndListen(event, emit);
    if (event is PoemsLoadCache) return _onLoadCache(event, emit);
    if (event is PoemsSortByType) return _onSort(event, emit);
    return null;
  }

  Future<void> _onLoadRemoteAndListen(PoemsLoadAndListen event, Emitter<PoemsState> emit) async {
    await emit.forEach<QuerySnapshot<Object?>>(
      poemsUseCase.poemsStream,
      onData: (data) { 
        final poems = poemsUseCase.doRemotePoemsAndListen(data);
        log('Remote');
        return PoemsLoaded(
          poems: poems,
          value: Topics.all,
          isSortedState: false
        );
      },
      onError: (error, stackTrace) => PoemsError(error: error),
    );
  }

  Future<void> _onLoadCache(PoemsLoadCache event, Emitter<PoemsState> emit) async {
    final topic = await cacheService.getTopicName();
    await poemsUseCase.doLocalPoems();
    log('Local');
    emit(PoemsLoaded(
      poems: poemsUseCase.poemsRepository.poems, 
      value: topic, 
      isSortedState: false
    ));
  }

  Future<void> _onSort(PoemsSortByType event, Emitter<PoemsState> emit) async {
    emit(PoemsLoading());
    await cacheService.saveTopicName(event.value.name);
    emit(PoemsLoaded(
      poems: poemsUseCase.sortPoemsByTopic(event.value), 
      value: event.value, 
      isSortedState: true
    ));
  }
}
