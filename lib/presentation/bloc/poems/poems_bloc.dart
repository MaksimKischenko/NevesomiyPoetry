import 'dart:developer';

import 'package:bloc/bloc.dart';
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

  List<Poem> poems = [];

  Future<void>? _onEvent(
    PoemsEvent event,
    Emitter<PoemsState> emit,
  ) {
    if (event is PoemsLoad) return _onLoad(event, emit);
    if (event is PoemsSortByType) return _onSort(event, emit);
    return null;
  }

  Future<void> _onLoad(PoemsLoad event, Emitter<PoemsState> emit) async {
    if (event.syncWithFireStore) {
      log('REMOTE');
      final result = await poemsUseCase.doRemotePoems();
      result.fold(
        (falure) => emit(PoemsError(error: falure.message)),
        (right) {
          poems = right;
        });
    } else {
      log('LOCAL');
      poems = await poemsUseCase.doLocalPoems();
    }
    final topic = await cacheService.getTopicName();
    emit(PoemsLoaded(
      poems: poems, 
      value: topic, 
      isSortedState: false
    ));
  }

  Future<void> _onSort(PoemsSortByType event, Emitter<PoemsState> emit) async {
    emit(PoemsLoading());
    poems = poemsUseCase.sortPoemsByTopic(event.value);
    await cacheService.saveTopicName(event.value.name);
    emit(PoemsLoaded(
      poems: poems, 
      value: event.value, 
      isSortedState: true
    ));
  }
}
