part of 'poems_bloc.dart';

sealed class PoemsEvent extends Equatable {
  const PoemsEvent();

  @override
  List<Object> get props => [];
}

final class PoemsLoadCache extends PoemsEvent {}

final class PoemsSortByType extends PoemsEvent {
  final Topics value;

   const PoemsSortByType({
    required this.value,
  }); 
}

final class PoemsLoadAndListen extends PoemsEvent {}
