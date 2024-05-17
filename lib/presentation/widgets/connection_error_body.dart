import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevesomiy/domain/entites/ettities.dart';
import 'package:nevesomiy/presentation/styles/styles.dart';

class ConnectionErrorBody extends StatelessWidget {
  const ConnectionErrorBody({super.key});

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                SvgRepo.wrench.location,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Проверьте соединение c интернетом', 
                  style: ModalDialogTextStyles.bodyTextStyle
              ))
            ],
          ),   
          const SizedBox(height: 12),      
          Row(
            mainAxisAlignment: MainAxisAlignment.start, 
            children: [
              SvgPicture.asset(
                SvgRepo.rocket.location,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text('Перезапустите соединение', 
                style: ModalDialogTextStyles.bodyTextStyle
              ))
            ],
          ),                                  
        ],
      ),
    );
}