import 'package:flutter/material.dart';
import 'package:friendzone/presentation/views/home/widgets/post_item.dart';
import '../../../../data/models/post.dart';

class ListPost extends StatelessWidget {
  final List<Post> listPost;
  const ListPost({super.key, required this.listPost});

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(childCount: listPost.length,
            (context, index) {
      final item = listPost[index];
      return listPost.isNotEmpty ? PostItem(item: item) : const SizedBox();
    }));
  }
}
