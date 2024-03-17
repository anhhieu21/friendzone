import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/core/utils/constants/gap.dart';
import 'package:friendzone/src/presentation/state/home/feed/feed_cubit.dart';
import 'package:friendzone/src/presentation/views/home/widgets/new_feed_item.dart';
import 'package:friendzone/src/presentation/widgets/image_view.dart';
import 'package:friendzone/src/utils.dart';
import 'package:go_router/go_router.dart';

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
            return list.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(Gap.s),
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width / 4,
                          height: size.width / 2.5,
                          child: Card(
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      const Positioned(
                                        top: 0,
                                        left: 0,
                                        right: 0,
                                        bottom: kIconBtnSize,
                                        child: ImageViewNetwork(
                                          src: urlAvatar,
                                          borderRadius: kBorderRadiusOnTop,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        child: IconButton.filledTonal(
                                          onPressed: () => context.pushNamed(
                                            RoutePath.routeName(
                                                RoutePath.upFeed),
                                          ),
                                          icon: const Icon(Icons.add),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Text(
                                    'Create\nstory',
                                    textAlign: TextAlign.center,
                                    style: context.theme.textTheme.titleSmall,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    height: size.width / 2.5,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: list.length,
                      itemBuilder: (context, index) => ItemNewFeed(
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
