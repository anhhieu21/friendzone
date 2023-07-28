import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:friendzone/data/models/feed.dart';
import 'package:friendzone/presentation/routes/path.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:friendzone/presentation/utils/formatter.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class ItemNewFeed extends StatelessWidget {
  final Size size;
  final Feed item;
  const ItemNewFeed({super.key, required this.size, required this.item});

  @override
  Widget build(BuildContext context) {
    return  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Container(
              width: size.width / 4,
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: colorWhite),
                  borderRadius: BorderRadius.circular(25)),
              child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          item.imagesUrl.first,
                        )),
                  )),
            ));
  }
}

class ItemAddFeed extends StatelessWidget {
  final Size size;
  const ItemAddFeed({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: GestureDetector(
          onTap: () =>
              context.pushNamed(Formatter.nameRoute(RoutePath.upStory)),
          child: Container(
              width: size.width / 4,
              height: size.height,
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  color: colorBlue.shade300.withOpacity(0.8),
                  border: Border.all(width: 2, color: colorWhite),
                  borderRadius: BorderRadius.circular(25)),
              child: Icon(
                Ionicons.add_circle,
                color: colorWhite,
                size: size.width / 10,
              )),
        ));
  }
}
