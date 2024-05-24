
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevesomiy/domain/entites/ettities.dart';
import 'package:nevesomiy/presentation/styles/styles.dart';


class SignOutTile extends StatelessWidget {
  final TextStyle? textStyle;
  final Function() onTap;

  const SignOutTile({
    super.key,
    required this.textStyle,
    required this.onTap,
  });


  @override
  Widget build(BuildContext context) => Ink(
    child: InkWell(
      onTap: onTap,  
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            SvgRepo.signOut.location,
            colorFilter: ColorFilter.mode(ColorStyles.pallete1.withOpacity(0.5), BlendMode.srcIn),
            width: 24,
            height: 24,
          ),     
          const SizedBox(width: 8),   
          Text(
            'Выйти', 
            style: textStyle
          ),
        ],
      )
    ),
  );
}
