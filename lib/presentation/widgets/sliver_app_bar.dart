// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:nevesomiy/domain/entites/svg_repo.dart';

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
          Ink(
            child: InkWell(
              onTap: onTap.call,
              child: SvgPicture.asset(
                SvgRepo.search.location,
                width: 34,
                height: 34,
              ),
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
