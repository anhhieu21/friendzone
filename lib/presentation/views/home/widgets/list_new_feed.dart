import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/presentation/views/home/widgets/new_feed_item.dart';
import 'package:friendzone/state/home/feed/feed_cubit.dart';

class ListNewFeed extends StatelessWidget {
  final Size size;
  const ListNewFeed({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
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
              return state.listFeed.isEmpty
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: ItemAddFeed(size: size))
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ItemAddFeed(size: size),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.listFeed.length,
                            itemBuilder: (context, index) => ItemNewFeed(
                                size: size,
                                item: state.listFeed[index],
                                index: index),
                          ),
                        ),
                      ],
                    );
            } else {
              return Align(
                  alignment: Alignment.centerLeft,
                  child: ItemAddFeed(size: size));
            }
          },
        ),
      ),
    );
  }
}
