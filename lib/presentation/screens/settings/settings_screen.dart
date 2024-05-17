import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevesomiy/domain/entites/ettities.dart';
import 'package:nevesomiy/presentation/bloc/bloc.dart';
import 'package:nevesomiy/presentation/widgets/widget.dart';

import 'widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AccountInfoTile(),
            Expanded(
              child: BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, state) {
                  return SvgPicture.asset(
                    state.isLight? 
                    SvgRepo.photo.location: 
                    SvgRepo.map.location,
                    width: 300,
                    height: 300,
                  );
                },
              ),
            ),
            const SettingsList(),
          ],
        ),
      ),
    );
  }
}
