import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:nevesomiy/domain/entites/ettities.dart';
import 'package:nevesomiy/presentation/styles/styles.dart';
import 'package:nevesomiy/presentation/widgets/widget.dart';

mixin ModalDialogs { 
    static Future<void> showMessage({
      required BuildContext context,
      String? email,
      DialogType type = DialogType.errorNetwork
    }) {
    
    late Color indicatorColor;
    late AnimateIndicatorsType animateIndicatorsType;
    late Widget child;
    late Widget title;

    switch (type) {
      case DialogType.errorNetwork:
        indicatorColor = ColorStyles.errorColor;
        animateIndicatorsType = AnimateIndicatorsType.errorNetworkConnection;
        child = const ConnectionErrorBody();
        title = SvgPicture.asset(
          SvgRepo.modem.location,
          width: 48,
          height: 48,
        );
        break;
      case DialogType.success:

        break;
      case DialogType.emailVerify:
        indicatorColor = ColorStyles.mainColor;
        animateIndicatorsType = AnimateIndicatorsType.info;
        child = VerificationEmailBody(
          email: email ?? '',
        );
        title = SvgPicture.asset(
          SvgRepo.email.location,
          width: 48,
          height: 48,
        );        
        break;
    } 
    return showDialog(
      context: context, 
      barrierDismissible: false,
      builder: ((context) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 80, 
            vertical: MediaQuery.of(context).size.height / 3.5
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),                      
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: ClipRRect(
                    child: Scaffold(
                      backgroundColor: Colors.white,
                      appBar: AppBar(
                        centerTitle: true,
                        automaticallyImplyLeading: false,
                        title: title
                      ),
                      body: child,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    AnimateIndicator(
                      indicatorsType: animateIndicatorsType,
                      indicatorsSize: 42,
                      color: indicatorColor
                    )
                  ],
                )   
              ],
            ),
          ),
        );
      })
    );   
  }

  static Future<T?> showScrollableDialog<T>({
    required BuildContext context,
    required Widget Function(
    BuildContext context)
    builder,
    double topCornerRadius = 12.0
  }) {{
      final topOffset = MediaQuery.of(context).padding.top +
          MediaQuery.of(context).copyWith().size.height * 0.2;
      return showModalBottomSheet<T>(
        context: context,
        builder: (context) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), 
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            // padding: MediaQuery.of(context).viewInsets,
            height: MediaQuery.of(context).copyWith().size.height - topOffset,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(topCornerRadius),
              child: Material(
                // child: builder(context, null),
                child: builder(context),
              ),
            ),
          ),
        ),
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(topCornerRadius))),
        backgroundColor: const Color(0xffFCFCFC),
      );
    }
  }
}


