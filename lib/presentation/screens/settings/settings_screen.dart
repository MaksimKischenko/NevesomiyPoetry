import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final textStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
      fontSize: 16
    );
    final iconWrapperColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: const SimpleAppBar(title: 'Настройки'),
      body: Padding(
        padding:  const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccountInfoTile(
              iconWrapperColor: iconWrapperColor,
              textStyle: textStyle,
              svgLocation: SvgRepo.account.location,
              info: 'Профиль: ${DataManager.instance.userEmail ?? 'Неизвестно'}' ,
            ),
            const SizedBox(height: 8),
            AccountInfoTile(
              iconWrapperColor: iconWrapperColor,
              textStyle: textStyle,
              svgLocation: SvgRepo.dateAdd.location,
              info: 'Профиль создан: ${DataManager.instance.creationDate?.toStringFormatted() ?? ''}',
            ),
            const SizedBox(height: 8),
            ThemeSwitcher(
              iconWrapperColor: iconWrapperColor,
              textStyle: textStyle,
              text: 'Темная тема',
              onChanged: ({required onChanged}) {
                context.read<ThemeBloc>().add(ThemeChange(isDark: onChanged));
              },
            ),  
            const SizedBox(height: 8),
            MessagesSwitcher(
              iconWrapperColor: iconWrapperColor,
              textStyle: textStyle,
              text: 'Включить уведомления',
              onChanged: ({required onChanged}) {
                context.read<CloudMessagingBloc>().add(CloudMessagingRun(isEnabled: onChanged));
              },
            ),    
            const Spacer(),         
            SignOutTile(
              iconWrapperColor: iconWrapperColor,
              textStyle: textStyle,
              onTap: () => logOut(context)
            )
          ],
        ),
      ) 
    ); 
  } 

  void logOut(BuildContext context) {
    context.read<AuthBloc>().add(AuthSignOut());
    context.read<ThemeBloc>().add(ThemeChange(isDark: false));
    context.read<CloudMessagingBloc>().add(const CloudMessagingRun(isEnabled: false));
    context.read<MenuBloc>().add(const MenuTabUpdate(tab: MenuTab.poems));
  }
}
