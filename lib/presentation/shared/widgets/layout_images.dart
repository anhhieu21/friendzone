import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LayoutImages extends StatelessWidget {
  final List<String> images;
  const LayoutImages({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return images.length == 1
        ? layoutFirstImage()
        : images.length == 2
            ? layoutSecondImage()
            : layoutThreeImage();
  }

  Widget layoutFirstImage() {
    return CachedNetworkImage(
      imageUrl: images.first,
      fit: BoxFit.cover,
    );
  }

  Widget layoutSecondImage() {
    return Row(
      children: [
        Flexible(
            flex: 1,
            child: CachedNetworkImage(
              imageUrl: images.first,
              fit: BoxFit.cover,
            )),
        const SizedBox(width: 8),
        Flexible(
            flex: 1,
            child: CachedNetworkImage(
              imageUrl: images.last,
              fit: BoxFit.cover,
            )),
      ],
    );
  }

  Widget layoutThreeImage() {
    return Row(
      children: [
        Flexible(
            flex: 1,
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: images.first,
                  fit: BoxFit.cover,
                  height: 120,
                ),
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: images[1],
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )),
        Flexible(
            flex: 1,
            child: CachedNetworkImage(
              imageUrl: images.last,
              fit: BoxFit.cover,
            )),
      ],
    );
  }
}
