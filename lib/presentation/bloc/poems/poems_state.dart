part of 'poems_bloc.dart';

sealed class PoemsState extends Equatable {
  const PoemsState();
  
  @override
  List<Object?> get props => [];
}

final class PoemsLoading extends PoemsState {}

final class PoemsLoaded extends PoemsState {
  final List<Poem> poems;
  final Topics value;
  final bool isSortedState;

  const PoemsLoaded({
    required this.poems,
    required this.value, 
    required this.isSortedState   
  });

  @override
  List<Object> get props => [poems, value, isSortedState];
}

final class PoemsError extends PoemsState {
  final Object? error;

  const PoemsError({
    required this.error
  });

  @override
  List<Object?> get props => [error];  
}
