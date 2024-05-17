import 'package:flutter/material.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SimpleAppBar({super.key});

  @override
  Widget build(BuildContext context) => AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Поэзия Максима Невесомого', 
          style: Theme.of(context).appBarTheme.titleTextStyle
        ),                
      );
  
  @override
  Size get preferredSize => const Size.fromHeight(60);
}



