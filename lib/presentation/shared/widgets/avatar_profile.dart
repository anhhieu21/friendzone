import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:friendzone/presentation/themes/color.dart';
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
        CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          imageBuilder: (context, imageProvider) => CircleAvatar(
            radius: radius * 1.05,
            backgroundColor: colorGrey.shade100,
            child: CircleAvatar(
              radius: radius,
              backgroundImage: imageProvider,
            ),
          ),
        ),
        if (!isViewer)
          Positioned(
            bottom: -5,
            right: 0,
            child: IconButton(
              constraints: BoxConstraints(maxWidth: radius, maxHeight: radius),
              padding: const EdgeInsets.all(4),
              style: IconButton.styleFrom(
                  backgroundColor: colorGrey.withOpacity(0.6)),
              onPressed: () {},
              icon: const Icon(
                Ionicons.camera,
                color: colorWhite,
                size: 18,
              ),
            ),
          )
      ],
    );
  }
}
