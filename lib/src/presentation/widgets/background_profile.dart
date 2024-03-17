import 'package:flutter/material.dart';
import 'package:friendzone/src/core/utils/extentions/build_context_extention.dart';
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
    final colorBox = context.theme.colorScheme.primaryContainer;
    return Stack(
      children: [
        url.isEmpty
            ? Container(
                color: colorBox,
                width: width,
                height: height,
              )
            : Image.network(
                url,
                fit: BoxFit.cover,
                width: width,
                height: height,
                errorBuilder: (context, url, error) => Container(
                  color: colorBox,
                  width: width,
                  height: height,
                ),
              ),
        if (!isViewer)
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton.filledTonal(
              onPressed: callback,
              icon: const Icon(Ionicons.pencil),
            ),
          )
      ],
    );
  }
}
