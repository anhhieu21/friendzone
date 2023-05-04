import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:ionicons/ionicons.dart';

class BackgroundProfile extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  const BackgroundProfile({
    super.key,
    required this.url,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          width: width,
          height: height,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: IconButton(
            constraints:
                BoxConstraints(maxWidth: width / 12, maxHeight: width / 12),
            padding: const EdgeInsets.all(4),
            style: IconButton.styleFrom(
                backgroundColor: colorGrey.withOpacity(0.6)),
            onPressed: () {},
            icon: const Icon(Ionicons.pencil, color: colorWhite, size: 18),
          ),
        )
      ],
    );
  }
}
