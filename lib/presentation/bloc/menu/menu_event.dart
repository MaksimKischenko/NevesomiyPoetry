part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object?> get props => [];
}

class MenuTabUpdate extends MenuEvent {
  final MenuTab? tab;

  const MenuTabUpdate({this.tab});

  @override
  List<Object?> get props => [tab];
}

class MenuHide extends MenuEvent {}

class MenuShow extends MenuEvent {}