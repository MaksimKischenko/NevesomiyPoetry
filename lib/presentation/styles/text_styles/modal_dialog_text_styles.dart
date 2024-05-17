import 'package:flutter/material.dart';
import 'package:nevesomiy/presentation/styles/styles.dart';

mixin ModalDialogTextStyles {
  static get appBarTextStyle => const TextStyle(
    fontSize: 14,
    fontFamily: 'Roboto',     
    color: Colors.white,
  );
  static get snackBarTextStyle => const TextStyle(
    fontSize: 14,
    fontFamily: 'Roboto',     
    color: Colors.white,
  );  
  static get bodyTextStyle => TextStyle(
    fontSize: 14,
    fontFamily: 'Pacifico',     
    color: ColorStyles.mainTextColor,
  );
}

