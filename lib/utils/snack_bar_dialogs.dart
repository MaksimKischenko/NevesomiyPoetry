import 'package:flutter/material.dart';
import 'package:nevesomiy/presentation/styles/styles.dart';

mixin SnackBarDialog {
  static final Color errorColor = ColorStyles.errorColor;
  static final Color okColor = ColorStyles.okColor;

  static Future<void> showSnackBar(BuildContext context, String message, bool error, [int duration = 3]) async{
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    final snackBar = SnackBar(
      content: Center(child: Text(message, style: ModalDialogTextStyles.snackBarTextStyle, textAlign: TextAlign.center)),
      duration: Duration(seconds: duration),
      backgroundColor: error? errorColor : okColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}