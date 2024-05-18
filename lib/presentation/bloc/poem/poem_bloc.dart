import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevesomiy/data/data.dart';
import 'package:nevesomiy/domain/domain.dart';

part 'poem_event.dart';
part 'poem_state.dart';

class PoemBloc extends Bloc<PoemEvent, PoemState> {
  final Poem poem;
  final PoemsUseCase poemsUseCase;
  PoemBloc({
    required this.poem
  }) : 
  poemsUseCase = PoemsUseCase.instance,
    super(
      PoemState(
        poem: poem 
    )) {
      on<PoemEvent>(_onEvent); 
    }

   Future<void>? _onEvent(
    PoemEvent event,
    Emitter<PoemState> emit,
  ) {
    if (event is PoemAction) return _onAction(event, emit);
    return null;
  }

  Future<void> _onAction(
    PoemAction event,
    Emitter<PoemState> emit,
  ) async {
    await poemsUseCase.poemMakeFavorite(poem, isFavorite: event.isFavorite);
    emit(state.copyWith(
      poem: poem.copyWith(
        isFavorite: event.isFavorite
      )
    ));
  }
}
