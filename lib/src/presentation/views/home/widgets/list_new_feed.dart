import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/presentation/state/home/feed/feed_cubit.dart';
import 'package:friendzone/src/presentation/state/profile/myaccount/my_account_cubit.dart';
import 'package:friendzone/src/presentation/views/home/widgets/new_feed_item.dart';
import 'package:friendzone/src/utils.dart';

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
                  ? const EmptyFeedList()
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
              return const EmptyFeedList();
            }
          },
        ),
      ),
    );
  }
}

class EmptyFeedList extends StatelessWidget {
  const EmptyFeedList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = SizeEx(context).screenSize;
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          width: size.width / 4,
          margin: const EdgeInsets.only(top: 10, left: 58),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(children: [
            Flexible(
              flex: 6,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                child: BlocBuilder<MyAccountCubit, MyAccountState>(
                  builder: (context, state) {
                    if (state is MyDataState) {
                      return CachedNetworkImage(
                        width: size.width / 4,
                        imageUrl: state.user.avartar,
                        fit: BoxFit.cover,
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
            const Flexible(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text('Post your feel'),
              ),
            )
          ]),
        ),
        const Positioned(left: 0, child: ItemAddFeed()),
      ],
    );
  }
}
