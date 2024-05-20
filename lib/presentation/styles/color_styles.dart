
import 'package:flutter/material.dart';


mixin ColorStyles {
  static Color get mainColor => const Color(0xff004976).withOpacity(0.8);
  static Color get mainColorSplash => const Color(0xff004976).withOpacity(0.3);           
  static MaterialAccentColor get errorColor => Colors.redAccent;
  static Color get okColor =>  Colors.green.withOpacity(0.5); 
  static Color get mainTextColor => Colors.black87.withOpacity(0.7);
  static Color get hintTextFieldColor => Colors.grey.shade600.withOpacity(0.8);
  static Color get iconTextFieldColor => Colors.grey.shade600.withOpacity(0.7); 
  static Color get buttonDissableColor => const Color(0xff8498BC).withOpacity(0.1);  
  static Color get assetDissableColor => Colors.blueGrey.withOpacity(0.2);  
  static Color get textFieldColor => Colors.black;
}

