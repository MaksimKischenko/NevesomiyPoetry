part of 'poems_bloc.dart';

sealed class PoemsEvent extends Equatable {
  const PoemsEvent();

  @override
  List<Object> get props => [];
}


final class PoemsSortByType extends PoemsEvent {
  final Topics value;

   const PoemsSortByType({
    required this.value,
  }); 
}

final class PoemsLoad extends PoemsEvent {
    final bool syncWithFireStore;

   const PoemsLoad({
    required this.syncWithFireStore,
  }); 
}

final class PoemsUpdateByPoem extends PoemsEvent {
  final Poem poem;

   const PoemsUpdateByPoem({
    required this.poem,
  }); 
}

final class PoemsSearch extends PoemsEvent {
  final String name;

   const PoemsSearch({
    required this.name,
  }); 
}


final class PoemsLoadAndListen extends PoemsEvent {}
