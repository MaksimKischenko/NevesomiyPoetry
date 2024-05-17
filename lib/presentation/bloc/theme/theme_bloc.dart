import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevesomiy/domain/domain.dart';

part 'theme_event.dart';
part 'theme_state.dart';


class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  CacheService cacheService;
  ThemeBloc(): 
  cacheService = CacheService.instance,
  super(
    const ThemeState(
      isLight: true
    )) {
    on<ThemeEvent>(_onEvent);
  }

  Future<void> _onEvent(
    ThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    if (event is ThemeChange) return _onThemeChanged(event, emit);
  }

  Future<void> _onThemeChanged(
    ThemeChange event,
    Emitter<ThemeState> emit,
  ) async {
    if(event.isLight == null) {
      event.isLight = await cacheService.getTheme();
      emit(state.copyWith(
        isLight: event.isLight 
      ));
    } else {
      await cacheService.saveTheme(isLightTheme: event.isLight ?? true);
      emit(state.copyWith(
        isLight: event.isLight,
      ));
    }
  }
}