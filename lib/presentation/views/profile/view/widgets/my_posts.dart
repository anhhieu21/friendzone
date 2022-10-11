import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:friendzone/common/constants/list_img_fake.dart';
import 'package:friendzone/presentation/views/profile/view/widgets/item_post.dart';

const kMaxCrossAxisExtent = 350.0;

class MyPosts extends StatelessWidget {
  final Size size;
  const MyPosts({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.extent(
        maxCrossAxisExtent: kMaxCrossAxisExtent,
        itemCount: listPost.length,
        shrinkWrap: true,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        itemBuilder: (context, index) {
          final item = listPost[index];
          return ItemPost(size: size, item: item);
        });
  }
}
