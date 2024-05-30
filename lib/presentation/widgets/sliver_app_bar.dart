import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:nevesomiy/domain/entites/svg_repo.dart';
import 'package:nevesomiy/presentation/styles/styles.dart';
import 'package:nevesomiy/presentation/widgets/widget.dart';

class SliverListAppBar extends SliverPersistentHeaderDelegate {
  final Function() onSearchTap;
  final Function() onChangeListType;
  final ValueNotifier<bool> isListType;
  
  const SliverListAppBar({
    required this.onSearchTap,
    required this.onChangeListType,
    required this.isListType
  });

  @override
  Widget build(
    BuildContext context, double shrinkOffset, bool overlapsContent) => Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: onChangeListType, 
          icon: ValueListenableBuilder(
            valueListenable: isListType,
            builder: (context, value, child) => Icon(
              isListType.value? Icons.list: Icons.grid_view, 
              size: 32, 
              color: ColorStyles.pallete3
            ),
          )
        ), 
        actions: [
          IconWrapper(
            color: ColorStyles.pallete3,
            onTap: onSearchTap,
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
