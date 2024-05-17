part of 'menu_bloc.dart';

class MenuState extends Equatable {
  final bool isVisible;
  final MenuTab tab;

  const MenuState({
    this.isVisible = true,
    required this.tab
  });

  @override
  List<Object> get props => [isVisible, tab];
  
  MenuState copyWith({
    bool? isVisible,
    MenuTab? tab,
  }) => MenuState(
    isVisible: isVisible ?? this.isVisible,
    tab: tab ?? this.tab,
  );
}