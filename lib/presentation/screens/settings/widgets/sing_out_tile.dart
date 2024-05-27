import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nevesomiy/domain/entites/ettities.dart';
import 'package:nevesomiy/presentation/bloc/bloc.dart';
import 'package:nevesomiy/presentation/styles/styles.dart';
import 'package:nevesomiy/presentation/widgets/icon_wrapper.dart';

class SignOutTile extends StatelessWidget {
  final TextStyle? textStyle;
  final Function() onTap;
  final Color iconWrapperColor;

  const SignOutTile({
    super.key, 
    required this.textStyle, 
    required this.onTap, 
    required this.iconWrapperColor
  });

  @override
  Widget build(BuildContext context) => BlocListener<AuthBloc, AuthState>(
    listener: (context, state) {
      if (state is AuthStreamStates) {
        if (state.user == null) {
          context.go('/auth');
        } 
      }          
    },
    child: Ink(
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconWrapper(
              onTap: null,
              color: iconWrapperColor,
              child: SvgPicture.asset(
                SvgRepo.signOut.location,
                colorFilter: ColorFilter.mode(ColorStyles.pallete3, BlendMode.srcIn),
                width: 24,
                height: 24,
              ),
            ),
            const SizedBox(width: 8),
            Text('Выйти', style: textStyle),
          ],
        )
      ),
    ),
  );
}
