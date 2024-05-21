part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}


// ignore: must_be_immutable
final class ThemeChange extends ThemeEvent {
  bool? isDark;

  ThemeChange({
    this.isDark
  });
}