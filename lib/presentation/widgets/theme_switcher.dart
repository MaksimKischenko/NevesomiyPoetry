import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nevesomiy/presentation/bloc/bloc.dart';

class ThemeSwitcher extends StatefulWidget {
  final String text;
  final Function(bool)? onChanged;


  const ThemeSwitcher({super.key, required this.text, this.onChanged});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  bool? isLightTheme;
  @override
  Widget build(BuildContext context) => BlocListener<ThemeBloc, ThemeState>(
        listener: (context, state) {
          isLightTheme = state.isLight;
        },
        child: Row(
          children: [
            CupertinoSwitch(
              value: isLightTheme ?? true,
              activeColor: Theme.of(context).colorScheme.secondary,
              onChanged: _onTap,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                widget.text,
                //style: AppStyles.checkBoxTextStyle
              ),
            ),
          ],
        ),
      );

  void _onTap(bool value) {
    setState(() {
      isLightTheme = value;
    });
    widget.onChanged?.call(value);
  }
}
