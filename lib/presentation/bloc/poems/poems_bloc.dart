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
    if (event is PoemsUpdateByPoem) return _onUpdatePoemsByPoem(event, emit);
    return null;
  }


  Future<void> _onLoad(PoemsLoad event, Emitter<PoemsState> emit) async {
    final topic = await cacheService.getTopicName();
    if (event.syncWithFireStore) {
      try {
        await poemsUseCase.doRemotePoems();
        log('REMOTE');
      } on FirebaseException catch (e) {
        emit(PoemsError(error: e));
      }
    } else {
      log('LOCAL');
      await poemsUseCase.doLocalPoems();
    }
    emit(PoemsLoaded(
      poems: poemsUseCase.poemsSortedBy(topic),   
      value: topic, 
    ));
  }

  Future<void> _onLoadRemoteAndListen(PoemsLoadAndListen event, Emitter<PoemsState> emit) async {
    final topic = await cacheService.getTopicName();
    try {
      await emit.forEach<QuerySnapshot<Object?>>(
        poemsUseCase.poemsStream,
        onData: (data) { 
          poemsUseCase.doRemotePoemsAndListen(data);
          return PoemsLoaded(
            poems: poemsUseCase.poemsSortedBy(topic),
            value: topic,
          );
        },
      );
    } on FirebaseException catch (e) {
      emit(PoemsError(error: e));
    }    
  }

  Future<void> _onSort(PoemsSortByType event, Emitter<PoemsState> emit) async {
    emit(PoemsLoading());
    await cacheService.saveTopicName(event.value.name);
    emit(PoemsLoaded(
      poems: poemsUseCase.poemsSortedBy(event.value), 
      value: event.value, 
    ));
  }

  Future<void> _onUpdatePoemsByPoem(PoemsUpdateByPoem event, Emitter<PoemsState> emit) async {
    emit(PoemsLoading());
    final topic = await cacheService.getTopicName();
    poemsUseCase.poemsRepository.poems.where((element) => element.content == event.poem.content).first.copyWith(peopleLiked: event.poem.peopleLiked);
    emit(PoemsLoaded(
      poems: poemsUseCase.poemsSortedBy(topic), 
      value: topic, 
    ));
  }
}
