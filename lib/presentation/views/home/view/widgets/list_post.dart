import 'package:flutter/material.dart';
import 'package:friendzone/common/constants/list_img_fake.dart';
import 'package:friendzone/presentation/views/home/view/widgets/post_item.dart';

class ListPost extends StatelessWidget {
  const ListPost({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: listPost.length,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          final item = listPost[index];
          return PostItem(item: item);
        });
  }
}
