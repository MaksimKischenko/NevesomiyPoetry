part of 'poem_bloc.dart';

class PoemState extends Equatable {
  final Poem poem;

  const PoemState({
    required this.poem
  });

  @override
  List<Object> get props => [poem];

  PoemState copyWith({
    Poem? poem,
  }) => PoemState(
    poem: poem ?? this.poem,
  );  
}

