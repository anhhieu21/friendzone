import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/core/utils/constants/gap.dart';
import 'package:friendzone/src/presentation/state/home/allpost/all_post_cubit.dart';
import 'package:friendzone/src/presentation/views/post/widgets/post_item.dart';
import 'package:friendzone/src/utils.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../domain/models/post.dart';

class ListPost extends StatelessWidget {
  final bool isLoading;
  const ListPost({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllPostCubit, AllPostState>(
      buildWhen: (previous, current) {
        return current is AllPostShow;
      },
      builder: (context, state) {
        final listPost = state is AllPostShow ? state.listPost : <Post>[];
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: listPost.length,
            (context, index) {
              final item = listPost[index];
              return listPost.isNotEmpty
                  ? _item(
                      item: item,
                      isLoadItem: isLoading && item == listPost.last)
                  : const SizedBox();
            },
          ),
        );
      },
    );
  }

  Widget _item({required Post item, required bool isLoadItem}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PostItem(item: item),
        if (isLoadItem) const ItemLoading(),
      ],
    );
  }
}

class ItemLoading extends StatelessWidget {
  const ItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final height = context.screenSize.width / 4;
    final widthContent = context.screenSize.width;
    return Padding(
      padding: const EdgeInsets.all(Gap.s),
      child: Shimmer.fromColors(
        baseColor: context.theme.primaryColor.withOpacity(0.2),
        highlightColor: context.theme.primaryColor.withOpacity(0.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: height,
              height: height,
              decoration: BoxDecoration(
                  color: context.theme.colorScheme.primary,
                  borderRadius: kBorderRadius),
            ),
            const SizedBox(width: 8.0),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: height / 5,
                  decoration: BoxDecoration(
                      color: context.theme.colorScheme.primary,
                      borderRadius: kBorderRadius),
                ),
                Container(
                  height: height / 5,
                  width: widthContent,
                  margin: const EdgeInsets.symmetric(vertical: Gap.s),
                  decoration: BoxDecoration(
                      color: context.theme.colorScheme.primary,
                      borderRadius: kBorderRadius),
                ),
                Container(
                  height: height / 5,
                  width: widthContent * 0.5,
                  decoration: BoxDecoration(
                      color: context.theme.colorScheme.primary,
                      borderRadius: kBorderRadius),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
