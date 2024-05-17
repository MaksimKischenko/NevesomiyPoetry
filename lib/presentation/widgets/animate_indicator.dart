import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:nevesomiy/domain/entites/ettities.dart';

class AnimateIndicator extends StatefulWidget {
  final Color color;
  final double indicatorsSize;
  final AnimateIndicatorsType indicatorsType;
  
  const AnimateIndicator({
    super.key,
    required this.indicatorsType,
    this.color = Colors.transparent,
    this.indicatorsSize = 24
  });

  @override
  State<AnimateIndicator> createState() => _AnimateIndicatorState();
}

class _AnimateIndicatorState extends State<AnimateIndicator> with TickerProviderStateMixin{

  late AnimationController _allertController;
  late AnimationController _infoController;

  @override
  void initState() {
    super.initState();
    _allertController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat();
    _infoController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));   
  }

 @override
  void dispose() {
    _allertController.dispose();
    _infoController.dispose();
    super.dispose();
  } 

  @override
  Widget build(BuildContext context) => switch(widget.indicatorsType) {
    AnimateIndicatorsType.errorNetworkConnection => LoadingAnimationWidget.staggeredDotsWave(
      color: widget.color,
      size: widget.indicatorsSize
    ),
   AnimateIndicatorsType.servicesError => const SizedBox.shrink(),
   AnimateIndicatorsType.info => LoadingAnimationWidget.staggeredDotsWave(
      color: widget.color,
      size: widget.indicatorsSize
    ),
  };
}

