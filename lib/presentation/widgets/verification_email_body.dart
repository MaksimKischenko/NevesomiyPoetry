// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:nevesomiy/presentation/styles/styles.dart';

class VerificationEmailBody extends StatelessWidget {
  final String email;

  const VerificationEmailBody({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/icons/email.svg',
                width: 48,
                height: 48,
              ),     
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Письмо выслано на $email', 
                  style: ModalDialogTextStyles.bodyTextStyle
              ))
            ],
          ),                                  
        ],
      ),
    );  
  }
}
