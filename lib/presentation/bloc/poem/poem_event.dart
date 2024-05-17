part of 'poem_bloc.dart';

sealed class PoemEvent extends Equatable {
  const PoemEvent();

  @override
  List<Object?> get props => [];
}


class PoemAction extends PoemEvent {
  final bool? isFavorite;

  const PoemAction({this.isFavorite});

  @override
  List<Object?> get props => [isFavorite]; 
}

