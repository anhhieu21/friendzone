import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:friendzone/common/constants/list_img_fake.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:ionicons/ionicons.dart';

class ToolBarReel extends StatelessWidget {
  const ToolBarReel({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: kToolbarHeight,
        left: 16.0,
        right: 16.0,
        child: Row(
          children: [
            const CircleAvatar(backgroundImage: CachedNetworkImageProvider(urlAvatar), radius: 30),
            Expanded(
                child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Solomon ares'),
                        TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: colorGrey.shade300,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0)),
                            onPressed: () {},
                            child: const Text('Follow')),
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Ionicons.arrow_redo)),
              ],
            ))
          ],
        ));
  }
}
