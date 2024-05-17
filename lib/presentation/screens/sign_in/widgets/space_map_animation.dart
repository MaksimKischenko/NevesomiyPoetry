// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:nevesomiy/domain/entites/ettities.dart';


class SpaceMapAnimation extends StatelessWidget {

  final AnimationController controller;
  final Animation<double> scaleAnimation;
  final Animation<Offset> positionAnimation;
  final Animation<double> opacityAnimationRocket;
  final Animation<double> opacityAnimationSpaceMap; 

  const SpaceMapAnimation({
    super.key,
    required this.controller,
    required this.scaleAnimation,
    required this.positionAnimation,
    required this.opacityAnimationRocket,
    required this.opacityAnimationSpaceMap
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: scaleAnimation.value,
              child: FadeTransition(
                opacity: opacityAnimationSpaceMap,
                child: SvgPicture.asset(
                  SvgRepo.globeMain.location,
                  width: 120,
                  height: 120,
                ),
              ),
            );
          },
        ),   
        Positioned(
          bottom: 10,
          right: 25,
          child: SlideTransition(
            position: positionAnimation,
            child: Transform.rotate(
              angle: 305 * (pi/180),   
              child: FadeTransition(
                opacity: opacityAnimationRocket,
                child: SvgPicture.asset(
                  SvgRepo.rocket.location,
                  width: 40,
                  height: 40,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}