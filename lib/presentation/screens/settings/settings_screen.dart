import 'package:flutter/material.dart';
import 'package:nevesomiy/data/data.dart';
import 'package:nevesomiy/domain/entites/ettities.dart';
import 'package:nevesomiy/presentation/widgets/widget.dart';
import 'package:nevesomiy/utils/date_helper.dart';

import 'widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) =>  Scaffold(
      appBar: const SimpleAppBar(),
      body: Padding(
        padding:  const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AccountInfoTile(
              svgLocation: SvgRepo.account.location,
              info: DataManager.instance.userEmail ?? 'Неизвестно',
            ),
            AccountInfoTile(
              svgLocation: SvgRepo.dateAdd.location,
              info: 'Профиль создан: ${DataManager.instance.creationDate?.toStringFormatted() ?? ''}',
            ),
            const Spacer(),
            const SettingsList(),
          ],
        ),
      ),
    );
}
