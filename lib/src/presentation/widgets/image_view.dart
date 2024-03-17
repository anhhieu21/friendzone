import 'package:flutter/material.dart';
import 'package:friendzone/src/utils.dart';

class ImageViewNetwork extends StatelessWidget {
  final String src;
  final BorderRadius? borderRadius;
  const ImageViewNetwork({
    super.key,
    required this.src,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? kBorderRadius,
      child: Image.network(
        src,
        fit: BoxFit.cover,
      ),
    );
  }
}
