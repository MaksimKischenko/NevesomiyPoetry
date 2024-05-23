// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const SimpleAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          title, 
          style: Theme.of(context).appBarTheme.titleTextStyle
        ),                
      );
  
  @override
  Size get preferredSize => const Size.fromHeight(40);
}



