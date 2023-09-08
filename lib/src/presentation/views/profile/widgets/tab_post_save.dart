import 'package:flutter/material.dart';
import 'package:friendzone/src/presentation/views/profile/widgets/item_post_save.dart';

import '../../../../domain/models/post.dart';

class TabPostSave extends StatelessWidget {
  final List<Post> listPost;
  const TabPostSave({super.key, required this.listPost});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: listPost.length,
          itemBuilder: (context, index) {
            final item = listPost[index];
            return ItemPostSave(post: item);
          }),
    );
  }
}