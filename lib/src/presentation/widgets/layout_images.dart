import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/presentation/shared.dart';
import 'package:friendzone/src/presentation/widgets/animation_image_view.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:transparent_image/transparent_image.dart';

class LayoutImages extends StatelessWidget {
  final List<String> images;
  const LayoutImages({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return images.length == 1
        ? layoutFirstImage(context)
        : layoutSecondImage(context);
  }

  Widget layoutFirstImage(BuildContext context) =>
      imageView(context, images.first);

  Widget layoutSecondImage(BuildContext context) {
    return StaggeredGrid.count(
        crossAxisCount: images.length,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        children: images
            .map(
              (e) => StaggeredGridTile.count(
                  crossAxisCellCount: e == images.first ? 2 : 1,
                  mainAxisCellCount: e == images.first ? 2 : 1,
                  child: imageView(context, e)),
            )
            .toList());
  }

  Widget imageView(BuildContext context, String url) {
    final currentPath = GoRouterState.of(context).path;
    return GestureDetector(
      onTap: currentPath != RoutePath.postDetail
          ? null
          : () => showViewDetail(context, url),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  showViewDetail(BuildContext context, url) =>
      CustomOverlayEntry.instance.showOverlay(context,
          withOpacity: false,
          child: ImageViewDetail(
            url: url,
            backPress: () => CustomOverlayEntry.instance.hideOverlay(),
            saveImage: () {},
          ));
}

class ImageViewDetail extends StatelessWidget {
  final String url;
  final VoidCallback backPress;
  final VoidCallback saveImage;
  const ImageViewDetail(
      {super.key,
      required this.url,
      required this.backPress,
      required this.saveImage});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: BackButton(onPressed: backPress),
            actions: [
              IconButton(
                  onPressed: saveImage,
                  icon: const Icon(
                    Ionicons.download_outline,
                  ))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
            child: AnimationImageView(
                child: PhotoView(
              maxScale: PhotoViewComputedScale.contained * 1.5,
              minScale: PhotoViewComputedScale.contained,
              initialScale: PhotoViewComputedScale.contained,
              imageProvider: NetworkImage(url),
            )),
          ),
        ));
  }
}
