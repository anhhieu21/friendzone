import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/presentation/state/home/feed/feed_cubit.dart';
import 'package:friendzone/src/presentation/views/home/widgets/new_feed_item.dart';

class ListNewFeed extends StatelessWidget {
  final Size size;
  const ListNewFeed({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: size.width * 0.4,
        child: BlocBuilder<FeedCubit, FeedState>(
          buildWhen: (previous, current) {
            if (current is FeedLoaded) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            if (state is FeedLoaded) {
              final list = state.listFeed;
              return list.isEmpty
                  ? const Align(
                      alignment: Alignment.centerLeft, child: ItemAddFeed())
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: list.length,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(left: index == 0 ? 50 : 0),
                            child: ItemNewFeed(
                                size: size, item: list[index], index: index),
                          ),
                        ),
                        const Positioned(left: 0, child: ItemAddFeed()),
                      ],
                    );
            } else {
              return const Align(
                  alignment: Alignment.centerLeft, child: ItemAddFeed());
            }
          },
        ),
      ),
    );
  }
}
