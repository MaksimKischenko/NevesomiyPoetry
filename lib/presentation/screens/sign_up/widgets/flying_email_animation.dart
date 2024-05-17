import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:nevesomiy/domain/entites/ettities.dart';


class FlyingEmailAnimation extends StatelessWidget {

  final AnimationController controller;
  final Animation<double> scaleAnimation;
  final Animation<Offset> positionAnimation;
  final Animation<double> opacityAnimationEmail;
  final Animation<double> rotationAnimationEmail; 
  final Animation<double> opacityAnimationIdCard; 

  const FlyingEmailAnimation({super.key, 
    required this.controller,
    required this.scaleAnimation,
    required this.positionAnimation,
    required this.rotationAnimationEmail,
    required this.opacityAnimationEmail,
    required this.opacityAnimationIdCard
  });

  @override
  Widget build(BuildContext context) => Stack(
      children: [
        AnimatedBuilder(
          animation: scaleAnimation,
          builder: (context, child) => Transform.scale(
              scale: scaleAnimation.value,
              child: FadeTransition(
                opacity: opacityAnimationIdCard,
                child: SvgPicture.asset(
                  SvgRepo.sun.location,
                  width: 120,
                  height: 120,
                ),
              ),
            ),
        ),   
        Positioned(
          bottom: 10,
          right: 25,
          child: SlideTransition(
            position: positionAnimation,
            child: Transform.rotate(
              angle: 305 * (pi/180),   
              child: FadeTransition(
                opacity: opacityAnimationEmail,
                child: SvgPicture.asset(
                  SvgRepo.plain.location,
                  width: 30,
                  height: 30,
                ),
              ),
            ),
          ),
        ),
      ],
    );
}