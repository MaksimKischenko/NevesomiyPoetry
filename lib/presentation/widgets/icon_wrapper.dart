import 'package:flutter/material.dart';

class IconWrapper extends StatelessWidget {
  final Color color;
  final Function()? onTap;
  final Widget child;

  const IconWrapper({
    Key? key,
    required this.color,
    required this.onTap,
    required this.child
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) => Material(
    elevation: 4,
    borderRadius: BorderRadius.circular(24),
    color: color.withOpacity(0.5),
    child: Ink(
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: child,
        ),
      ),
    )
  );
}
