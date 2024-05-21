import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nevesomiy/presentation/bloc/bloc.dart';

class ThemeSwitcher extends StatefulWidget {
  final String text;
  final Function({required bool onChanged})? onChanged;

  const ThemeSwitcher({
    Key? key,
    required this.text,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {

  final ValueNotifier<bool> isDarkTheme = ValueNotifier(false);

  @override
  Widget build(BuildContext context) => BlocListener<ThemeBloc, ThemeState>(
        listener: (context, state) {
          isDarkTheme.value = state.isDarkTheme;
        },
        child: Row(
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: isDarkTheme,
              builder: (context, value, child) => CupertinoSwitch(
                value: isDarkTheme.value,
                activeColor: Theme.of(context).colorScheme.secondary,
                onChanged: _onTap,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                widget.text,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      );

  void _onTap(bool value) {
    isDarkTheme.value = value;
    widget.onChanged?.call(onChanged: value);
  }
}
