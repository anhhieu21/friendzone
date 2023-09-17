import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/presentation/state/home/allpost/all_post_cubit.dart';
import 'package:friendzone/src/presentation/views/post/widgets/post_item.dart';
import '../../../../domain/models/post.dart';
import 'package:shimmer/shimmer.dart';

class ListPost extends StatelessWidget {
  final bool isLoading;
  const ListPost({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllPostCubit, AllPostState>(builder: (context, state) {
      final listPost = state is AllPostShow ? state.listPost : <Post>[];
      return SliverList(
          delegate: SliverChildBuilderDelegate(childCount: listPost.length,
              (context, index) {
        final item = listPost[index];
        return listPost.isNotEmpty
            ? _item(item: item, isLoadItem: isLoading && item == listPost.last)
            : const SizedBox();
      }));
    });
  }

  Widget _item({required Post item, required bool isLoadItem}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PostItem(item: item),
        if (isLoadItem)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Shimmer.fromColors(
              baseColor: colorGrey.shade100,
              highlightColor: colorGrey.shade300,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          color: colorWhite,
                          borderRadius: BorderRadius.circular(16.0))),
                  const SizedBox(width: 8.0),
                  Expanded(
                      child: Column(
                    children: [
                      Container(
                          height: 20,
                          decoration: BoxDecoration(
                              color: colorWhite,
                              borderRadius: BorderRadius.circular(16.0))),
                      Container(
                          height: 20,
                          margin: const EdgeInsets.only(
                              right: 50, top: 8, bottom: 8),
                          decoration: BoxDecoration(
                              color: colorWhite,
                              borderRadius: BorderRadius.circular(16.0))),
                      Container(
                          height: 20,
                          margin: const EdgeInsets.only(right: 50),
                          decoration: BoxDecoration(
                              color: colorWhite,
                              borderRadius: BorderRadius.circular(16.0))),
                    ],
                  ))
                ],
              ),
            ),
          )
      ],
    );
  }
}
