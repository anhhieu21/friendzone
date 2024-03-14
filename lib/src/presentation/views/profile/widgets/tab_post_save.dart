import 'package:flutter/material.dart';
import 'package:friendzone/src/core/config/routes/path.dart';
import 'package:friendzone/src/presentation/views/profile/widgets/item_post_save.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/models/post.dart';

class TabPostSave extends StatelessWidget {
  final List<Post> listPost;
  const TabPostSave({super.key, required this.listPost});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listPost.length,
        itemBuilder: (context, index) {
          final item = listPost[index];
          return InkWell(
              onTap: () {
                context.pushNamed(RoutePath.routeName(RoutePath.postDetail),
                    extra: item);
              },
              child: ItemPostSave(post: item));
        });
  }
}
