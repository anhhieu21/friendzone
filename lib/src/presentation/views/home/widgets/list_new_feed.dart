import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/core/utils/constants/gap.dart';
import 'package:friendzone/src/presentation/state/home/feed/feed_cubit.dart';
import 'package:friendzone/src/presentation/views/home/widgets/new_feed_item.dart';
import 'package:friendzone/src/utils.dart';

class ListNewFeed extends StatelessWidget {
  const ListNewFeed({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return SliverToBoxAdapter(
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
            return Container(
              margin: const EdgeInsets.only(top: Gap.s),
              height: size.width / 2.5,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, index) => index == 0
                    ? const ItemAddFeed()
                    : ItemNewFeed(
                        item: list[index],
                        index: index,
                      ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
