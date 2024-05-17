import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nevesomiy/domain/entites/ettities.dart';
import 'package:nevesomiy/presentation/bloc/bloc.dart';
import 'package:nevesomiy/presentation/screens/settings/widgets/widgets.dart';
import 'package:nevesomiy/presentation/widgets/widget.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ThemeSwitcher(
          text: 'Светлая тема',
          onChanged: (value) {
            context.read<ThemeBloc>().add(ThemeChange(isLight: value));
          },
        ),  
        const SizedBox(height: 16),    
        SignOutTile(
          onTap: () {
            context.read<AuthBloc>().add(AuthSignOut());
            context.go('/auth');
            context.read<MenuBloc>().add(const MenuTabUpdate(tab: MenuTab.poems));
          },
        )
      ],
    );
}
