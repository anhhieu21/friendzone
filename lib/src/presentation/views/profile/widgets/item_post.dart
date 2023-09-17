import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/domain/models/post.dart';
import 'package:go_router/go_router.dart';

import 'package:ionicons/ionicons.dart';

class ItemPost extends StatelessWidget {
  final Size size;
  final Post item;
  const ItemPost({super.key, required this.size, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed(RoutePath.routeName(RoutePath.postDetail),
          extra: item),
      child: Stack(
        children: [
          Container(
            width: size.width / 2,
            height: size.width / 1.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      item.imagesUrl.first,
                    ),
                    fit: BoxFit.cover)),
          ),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                  decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [
                    colorGrey.withOpacity(0.0),
                    colorGrey.withOpacity(0.1),
                    colorGrey.withOpacity(0.3),
                    colorGrey.withOpacity(0.5),
                  ],
                  tileMode: TileMode.clamp,
                  begin: const Alignment(0.0, 0.0),
                  end: const Alignment(0.0, 0.6),
                ),
              ))),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Ionicons.heart_outline,
                        color: colorBlue.shade400,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Ionicons.chatbubble_ellipses_outline,
                        color: colorBlue.shade400,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Ionicons.arrow_redo_outline,
                        color: colorBlue.shade400,
                      )),
                ],
              ))
        ],
      ),
    );
  }
}
