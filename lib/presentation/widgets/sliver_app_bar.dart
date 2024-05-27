import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:nevesomiy/domain/entites/svg_repo.dart';
import 'package:nevesomiy/presentation/styles/styles.dart';
import 'package:nevesomiy/presentation/widgets/widget.dart';

class SliverListAppBar extends SliverPersistentHeaderDelegate {
  final Function() onTap;
  
  const SliverListAppBar({
    required this.onTap,
  });

  @override
  Widget build(
    BuildContext context, double shrinkOffset, bool overlapsContent) => Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconWrapper(
            color: ColorStyles.pallete3,
            onTap: onTap,
            child: SvgPicture.asset(
              SvgRepo.search.location,
              width: 24,
              height: 24,
            ),
          ),            
        ],
        title: Text(
          'Стихи', 
          style: Theme.of(context).appBarTheme.titleTextStyle
        ),   
      ),
    );

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
