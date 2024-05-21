// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nevesomiy/presentation/bloc/bloc.dart';

class ThemeSwitcher extends StatelessWidget {
  final String text;
  final Function({required bool onChanged})? onChanged;

  ThemeSwitcher({
    Key? key,
    required this.text,
    required this.onChanged,
  }) : super(key: key);


  final ValueNotifier<bool> isLightTheme = ValueNotifier(false);

  @override
  Widget build(BuildContext context) => BlocListener<ThemeBloc, ThemeState>(
        listener: (context, state) {
          isLightTheme.value = state.isLight;
        },
        child: Row(
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: isLightTheme,
              builder: (context, value, child) => CupertinoSwitch(
                value: isLightTheme.value,
                activeColor: Theme.of(context).colorScheme.secondary,
                onChanged: _onTap,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                //style: AppStyles.checkBoxTextStyle
              ),
            ),
          ],
        ),
      );

  void _onTap(bool value) {
    isLightTheme.value = value;
    onChanged?.call(onChanged: value);
  }
}
