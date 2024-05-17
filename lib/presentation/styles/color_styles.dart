
import 'package:flutter/material.dart';


mixin ColorStyles {
  static get mainColor => const Color(0xff004976).withOpacity(0.8);
  static get mainColorSplash => const Color(0xff004976).withOpacity(0.3);           
  static get errorColor => Colors.redAccent;
  static get okColor =>  Colors.greenAccent.shade200; 
  static get mainTextColor => Colors.black87.withOpacity(0.7);
  static get hintTextFieldColor => Colors.grey.shade600.withOpacity(0.8);
  static get iconTextFieldColor => Colors.grey.shade600.withOpacity(0.7); 
  static get buttonDissableColor => const Color(0xff8498BC).withOpacity(0.1);  
  static get assetDissableColor => Colors.blueGrey.withOpacity(0.2);  
  static get textFieldColor => Colors.black;
}

