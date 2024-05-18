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
      poemsUseCase = PoemsUseCase(),
      super(PoemsLoading()) {
    on<PoemsEvent>(_onEvent);
  }

  late List<Poem> tempPoems;
  late PoemsState tempState;

  Future<void>? _onEvent(
    PoemsEvent event,
    Emitter<PoemsState> emit,
  ) {
    if (event is PoemsLoad) return _onLoad(event, emit);
    if (event is PoemsSortByType) return _onSort(event, emit);
    if (event is PoemsOnListen) return _onListen(event, emit);
    return null;
  }

  Future<void> _onLoad(PoemsLoad event, Emitter<PoemsState> emit) async {
    if (event.syncWithFireStore) {
      log('REMOTE');
      final result = await poemsUseCase.doRemotePoems();
      result.fold(
        (falure) => emit(PoemsError(error: falure.message)),
        (right) {
          tempPoems = right;
        });
    } else {
      log('LOCAL');
      tempPoems = await poemsUseCase.doLocalPoems();
    }
    final topic = await cacheService.getTopicName();
    tempState = PoemsLoaded(
      poems: tempPoems, 
      value: topic, 
      isSortedState: false
    );
    emit(tempState);
  }

  Future<void> _onSort(PoemsSortByType event, Emitter<PoemsState> emit) async {
    emit(PoemsLoading());
    tempPoems = poemsUseCase.sortPoemsByTopic(event.value);
    await cacheService.saveTopicName(event.value.name);
    emit(PoemsLoaded(
      poems: tempPoems, 
      value: event.value, 
      isSortedState: true
    ));
  }

  Future<void> _onListen(PoemsOnListen event, Emitter<PoemsState> emit) async {
    await emit.forEach<QuerySnapshot<Object?>>(
      poemsUseCase.poemsStream,
      onData: (data) { 
        final poems = poemsUseCase.parseByTracker(data);
        log('Stream: ${poems}');
        if(poems.length != tempPoems.length) {
          return PoemsLoaded(
            poems: poems,
            value: Topics.all,
            isSortedState: true
          );
        } else {
          return tempState;
        }
      },
      onError: (error, stackTrace) => PoemsError(error: error),
    );
  }
}
