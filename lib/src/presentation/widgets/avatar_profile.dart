import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AvatarProfile extends StatelessWidget {
  final String url;
  final double radius;
  final bool isViewer;
  const AvatarProfile(
      {super.key,
      required this.url,
      required this.radius,
      this.isViewer = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius * 1.05,
          child: CircleAvatar(
            radius: radius,
            backgroundImage: NetworkImage(url),
          ),
        ),
        if (!isViewer)
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton.filledTonal(
              onPressed: () {},
              icon: const Icon(
                Ionicons.camera,
              ),
            ),
          )
      ],
    );
  }
}
