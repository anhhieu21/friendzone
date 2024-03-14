import 'package:flutter/material.dart';
import 'package:friendzone/src/config.dart';
import 'package:ionicons/ionicons.dart';

class BackgroundProfile extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final bool isViewer;
  final VoidCallback? callback;
  const BackgroundProfile({
    super.key,
    required this.url,
    required this.width,
    required this.height,
    this.isViewer = false,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        url.isEmpty
            ? Container(
                color: colorGrey,
                width: width,
                height: height,
              )
            : Image.network(
                url,
                fit: BoxFit.cover,
                width: width,
                height: height,
                errorBuilder: (context, url, error) =>
                    Container(color: colorGrey),
              ),
        if (!isViewer)
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              constraints:
                  BoxConstraints(maxWidth: width / 12, maxHeight: width / 12),
              padding: const EdgeInsets.all(4),
              style: IconButton.styleFrom(
                  backgroundColor: colorGrey.withOpacity(0.6)),
              onPressed: callback,
              icon: const Icon(Ionicons.pencil, color: colorWhite, size: 18),
            ),
          )
      ],
    );
  }
}
