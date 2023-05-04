import 'package:flutter/material.dart';


class OnTapEffect extends StatelessWidget {
  final Function() onTap;
  final Widget child;
  final double radius;
  const OnTapEffect(
      {super.key,
      required this.onTap,
      required this.child,
      required this.radius});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: onTap,
          child: child,
        ));
  }
}
