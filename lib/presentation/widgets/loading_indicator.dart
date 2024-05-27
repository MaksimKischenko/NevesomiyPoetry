import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nevesomiy/presentation/styles/styles.dart';


class LoadingIndicator extends StatelessWidget {
  final Color color;
  final double indicatorsSize;
  
  const LoadingIndicator({
    super.key,
    this.color = Colors.transparent,
    this.indicatorsSize = 24
  });

  @override
  Widget build(BuildContext context) => LoadingAnimationWidget.discreteCircle(
    color: color,
    secondRingColor: ColorStyles.pallete2,
    thirdRingColor: ColorStyles.pallete3,
    size: indicatorsSize
  );
  
  // SimpleCircularProgressBar(
  //   backStrokeWidth: 3,
  //   progressStrokeWidth: 6,
  //   animationDuration: 10,
  //   startAngle: 0,
  //   size: indicatorsSize,
  //   mergeMode: true,
  //   progressColors: [color],
  //   backColor: color,
  // );
}