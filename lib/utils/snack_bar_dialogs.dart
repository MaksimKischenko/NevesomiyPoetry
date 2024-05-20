import 'package:flutter/material.dart';
import 'package:nevesomiy/presentation/styles/styles.dart';

mixin SnackBarDialog {
  static final Color errorColor = ColorStyles.errorColor;
  static final Color okColor = ColorStyles.okColor;

  static Future<void> showSnackBar(BuildContext context, String message, {required bool isError}) async{
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    final snackBar = SnackBar(
      content: Center(child: Text(message, style: ModalDialogTextStyles.snackBarTextStyle, textAlign: TextAlign.center)),
      duration: const Duration(seconds: 2),
      backgroundColor: isError? errorColor : okColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}