import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevesomiy/domain/entites/ettities.dart';

import 'package:nevesomiy/presentation/bloc/bloc.dart';
import 'package:nevesomiy/presentation/styles/styles.dart';

class ThemeSwitcher extends StatefulWidget {
  final TextStyle? textStyle;
  final String text;
  final Function({required bool onChanged})? onChanged;

  const ThemeSwitcher({
    Key? key,
    required this.textStyle,
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
            SvgPicture.asset(
              SvgRepo.theme.location,
              colorFilter: ColorFilter.mode(ColorStyles.pallete1.withOpacity(0.5), BlendMode.srcIn),
              width: 24,
              height: 24
            ),    
            const SizedBox(width: 8),           
            Expanded(
              child: Text(
                widget.text,
                style: widget.textStyle
              ),
            ),       
            ValueListenableBuilder<bool>(
              valueListenable: isDarkTheme,
              builder: (context, value, child) => Switch(
                value: isDarkTheme.value,
                activeColor: Theme.of(context).colorScheme.secondary,
                onChanged: _onTap,
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
