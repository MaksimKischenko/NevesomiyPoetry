import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nevesomiy/data/data.dart';
import 'package:nevesomiy/domain/entites/ettities.dart';
import 'package:nevesomiy/presentation/bloc/bloc.dart';
import 'package:nevesomiy/presentation/widgets/widget.dart';
import 'package:nevesomiy/utils/date_helper.dart';

import 'widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) { 

    final textCommonStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
      fontSize: 16
    );

    return Scaffold(
      appBar: const SimpleAppBar(title: 'Настройки'),
      body: Padding(
        padding:  const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccountInfoTile(
              textStyle: textCommonStyle,
              svgLocation: SvgRepo.account.location,
              info: DataManager.instance.userEmail ?? 'Неизвестно',
            ),
            const SizedBox(height: 8),
            AccountInfoTile(
              textStyle: textCommonStyle,
              svgLocation: SvgRepo.dateAdd.location,
              info: 'Профиль создан: ${DataManager.instance.creationDate?.toStringFormatted() ?? ''}',
            ),
            // const Spacer(),
            ThemeSwitcher(
              textStyle: textCommonStyle,
              text: 'Темная тема',
              onChanged: ({required onChanged}) {
                context.read<ThemeBloc>().add(ThemeChange(isDark: onChanged));
              },
            ),  
            MessagesSwitcher(
              textStyle: textCommonStyle,
              text: 'Включить уведомления',
              onChanged: ({required onChanged}) {
                context.read<CloudMessagingBloc>().add(CloudMessagingFlag(isEnabled: onChanged));
              },
            ),    
            const Spacer(),         
            SignOutTile(
              textStyle: textCommonStyle,
              onTap: () => logOut(context)
            )
          ],
        ),
      ) 
    ); 
  } 

  void logOut(BuildContext context) {
    context.read<AuthBloc>().add(AuthSignOut());
    context.go('/auth');
    context.read<MenuBloc>().add(const MenuTabUpdate(tab: MenuTab.poems));
  }
}
