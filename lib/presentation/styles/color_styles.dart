
import 'package:flutter/material.dart';


mixin ColorStyles {
  static Color get pallete1 => const Color(0xff4297A0);
  static Color get pallete2 => const Color(0xffE57F84);
  static Color get pallete3 => const Color(0xffF4EAE6);
  static Color get pallete4 => const Color(0xff2F5061);
  
  static Color get mainColorSplash => pallete1.withOpacity(0.3);     
  static Color get assetDissableColor => pallete4.withOpacity(0.5);    

       
  static MaterialAccentColor get errorColor => Colors.redAccent;
  static Color get okColor =>  Colors.green.withOpacity(0.5); 
  static Color get mainTextColor => Colors.black87.withOpacity(0.7);
  static Color get hintTextFieldColor => Colors.grey.shade600.withOpacity(0.8);
  static Color get iconTextFieldColor => Colors.grey.shade600.withOpacity(0.7); 
  static Color get buttonDissableColor => const Color(0xff8498BC).withOpacity(0.1);  
  
  static Color get textFieldColor => Colors.black;
}

