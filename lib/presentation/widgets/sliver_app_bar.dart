import 'package:flutter/material.dart';

class SliverListAppBar extends SliverPersistentHeaderDelegate {

  @override
  Widget build(
    BuildContext context, double shrinkOffset, bool overlapsContent) => Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Поэзия Максима Невесомого', 
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