part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final bool isDarkTheme;
  
  const ThemeState({
    required this.isDarkTheme
  });
  
  @override
  List<Object> get props => [isDarkTheme];

  ThemeState copyWith({
    bool? isDarkTheme,
  }) => ThemeState(
    isDarkTheme: isDarkTheme ?? this.isDarkTheme,
  );
}


