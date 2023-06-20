import 'package:flutter/material.dart';
import 'package:friendzone/data/models/post.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:ionicons/ionicons.dart';

class PostButtonBar extends StatelessWidget {
  final Post post;
  final Function(BuildContext context) callBack;
  const PostButtonBar({super.key, required this.post, required this.callBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () => callBack(context),
            icon: Row(
              children: [
                Icon(
                  Ionicons.heart_outline,
                  color: colorBlue.shade400,
                ),
                Text(post.like)
              ],
            )),
        IconButton(
            onPressed: () {},
            icon: Row(
              children: [
                Icon(
                  Ionicons.chatbubble_ellipses_outline,
                  color: colorBlue.shade400,
                ),
                const Text('12 comments')
              ],
            )),
        IconButton(
            onPressed: () {},
            icon: Row(
              children: [
                Icon(
                  Ionicons.arrow_redo_outline,
                  color: colorBlue.shade400,
                ),
                const Text('4 shared')
              ],
            )),
      ],
    );
  }
}
