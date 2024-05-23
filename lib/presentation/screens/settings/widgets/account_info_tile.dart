import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevesomiy/presentation/styles/styles.dart';

class AccountInfoTile extends StatelessWidget {
  final TextStyle? textStyle;
  final String svgLocation;
  final String info;

  const AccountInfoTile({
    super.key, 
    required this.textStyle,
    required this.svgLocation, 
    required this.info
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        SvgPicture.asset(
          svgLocation,
          colorFilter: ColorFilter.mode(ColorStyles.mainColor.withOpacity(0.5), BlendMode.srcIn),
          width: 24,
          height: 24
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            info,
            style: textStyle
          ),
        ),
      ],
    ),
  );
}