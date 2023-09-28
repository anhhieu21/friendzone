import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/domain.dart';

import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../../widgets/ontap_effect.dart';

class ItemNewFeed extends StatelessWidget {
  final Size size;
  final Feed item;
  final int index;
  const ItemNewFeed(
      {super.key, required this.size, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Container(
          width: size.width / 4,
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          child: Stack(
            children: [
              OnTapEffect(
                onTap: () => context.pushNamed(
                    RoutePath.routeName(RoutePath.detailFeed),
                    extra: index),
                radius: 20,
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
              ),
              Positioned(
                  top: 6,
                  left: 6,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: colorBlue,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundImage:
                          CachedNetworkImageProvider(item.avartarAuthor),
                    ),
                  ))
            ],
          ),
        ));
  }
}

class ItemAddFeed extends StatelessWidget {
  const ItemAddFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed(RoutePath.routeName(RoutePath.upFeed)),
      child: Container(
          width: 50,
          height: 50,
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              color: colorBlue.shade300.withOpacity(0.8),
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(26),
                  bottomRight: Radius.circular(26))),
          child: const Icon(
            Ionicons.add_circle,
            color: colorWhite,
            size: 40,
          )),
    );
  }
}
