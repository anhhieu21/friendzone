import 'package:flutter/material.dart';
import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/domain/models/post.dart';
import 'package:friendzone/src/utils.dart';
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
                    image: NetworkImage(
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
                borderRadius: kBorderRadius,
                gradient: kGradient,
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton.filledTonal(
                      onPressed: () {},
                      icon: const Icon(
                        Ionicons.heart_outline,
                      )),
                  IconButton.filledTonal(
                      onPressed: () {},
                      icon: const Icon(
                        Ionicons.chatbubble_ellipses_outline,
                      )),
                  IconButton.filledTonal(
                      onPressed: () {},
                      icon: const Icon(
                        Ionicons.arrow_redo_outline,
                      )),
                ],
              ))
        ],
      ),
    );
  }
}
