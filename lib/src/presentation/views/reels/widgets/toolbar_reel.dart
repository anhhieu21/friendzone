import 'package:flutter/material.dart';

import 'package:ionicons/ionicons.dart';

import '../../../../core/utils/constants/list_img_fake.dart';

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
            const CircleAvatar(
                backgroundImage: NetworkImage(urlAvatar), radius: 30),
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
