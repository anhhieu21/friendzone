import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/presentation/views/home/bloc/feed_cubit/new_feeds_cubit.dart';
import 'package:friendzone/presentation/views/home/view/widgets/new_feed_item.dart';

class ListNewFeed extends StatelessWidget {
  final Size size;
  const ListNewFeed({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        height: size.width * 0.4,
        child: BlocBuilder<NewFeedsCubit, NewFeedsState>(
          builder: (context, state) {
            if (state is NewFeedsShow) {
              if (state.listPost.isEmpty) {
                return const Center(
                  child: Text('Không có bài viết nào cả'),
                );
              }
              return ListView(
                scrollDirection: Axis.horizontal,
                children: state.listPost
                    .map((e) => ItemNewFeed(size: size, item: e))
                    .toList(),
              );
            } else {
              return const Center(
                child: Text('Không có bài viết nào cả'),
              );
            }
          },
        ),
      ),
    );
  }
}
