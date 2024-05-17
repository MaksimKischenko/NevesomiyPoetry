import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nevesomiy/presentation/routes.dart';
import 'package:nevesomiy/presentation/themes.dart';

import 'presentation/bloc/bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          routerConfig: router, 
          theme: state.isLight? 
            AppThemes.ligthTheme: 
            AppThemes.darkTheme
        );
      },
    );
  }
}
