import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevesomiy/domain/entites/ettities.dart';

import 'package:nevesomiy/presentation/bloc/bloc.dart';
import 'package:nevesomiy/presentation/styles/styles.dart';
import 'package:nevesomiy/presentation/widgets/icon_wrapper.dart';

class ThemeSwitcher extends StatefulWidget {
  final TextStyle? textStyle;
  final String text;
  final Color iconWrapperColor;
  final Function({required bool onChanged})? onChanged;

  const ThemeSwitcher({
    Key? key,
    required this.textStyle,
    required this.iconWrapperColor,
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
            IconWrapper(
              onTap: null,
              color: widget.iconWrapperColor,
              child: SvgPicture.asset(
                SvgRepo.theme.location,
                colorFilter: ColorFilter.mode(ColorStyles.pallete3, BlendMode.srcIn),
                width: 24,
                height: 24
              ),
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
                activeTrackColor: ColorStyles.pallete1,
                inactiveTrackColor: ColorStyles.pallete2.withOpacity(0.5),
                inactiveThumbColor: ColorStyles.pallete3,
                activeColor: ColorStyles.pallete3,
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
