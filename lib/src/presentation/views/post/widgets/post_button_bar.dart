import 'package:flutter/material.dart';
import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/presentation/state/settings/language/language_cubit.dart';

import 'package:ionicons/ionicons.dart';

class PostButtonBar extends StatelessWidget {
  final Post post;
  final bool? liked;
  final Function(MenuPost menuPost) callBack;
  const PostButtonBar(
      {super.key, required this.post, required this.callBack, this.liked});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () => callBack(MenuPost.like),
            icon: Row(
              children: [
                Icon(
                  liked != null && liked!
                      ? Ionicons.heart
                      : Ionicons.heart_outline,
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
                Text('${post.totalComment} ${text.comments}')
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
                Text(text.shared)
              ],
            )),
      ],
    );
  }
}
