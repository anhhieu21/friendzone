import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class LayoutImages extends StatelessWidget {
  final List<String> images;
  const LayoutImages({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return images.length == 1 ? layoutFirstImage() : layoutSecondImage();
  }

  Widget layoutFirstImage() {
    return CachedNetworkImage(
      imageUrl: images.first,
      fit: BoxFit.cover,
    );
  }

  Widget layoutSecondImage() {
    return StaggeredGrid.count(
        crossAxisCount: images.length,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        children: images
            .map(
              (e) => StaggeredGridTile.count(
                crossAxisCellCount: e == images.first ? 2 : 1,
                mainAxisCellCount: e == images.first ? 2 : 1,
                child: CachedNetworkImage(
                  imageUrl: e,
                  fit: BoxFit.cover,
                ),
              ),
            )
            .toList());
  }
}
