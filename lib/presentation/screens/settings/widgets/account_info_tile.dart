import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevesomiy/data/data_manager.dart';
import 'package:nevesomiy/domain/entites/svg_repo.dart';

class AccountInfoTile extends StatelessWidget {
  const AccountInfoTile({super.key});

  @override
  Widget build(BuildContext context) => ListTile(
      leading: SvgPicture.asset(
        SvgRepo.man.location,
        width: 48,
        height: 48
      ),
      title: Text(
        '${DataManager.instance.userEmail}',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
}