import 'package:flutter/material.dart';
import 'package:friendzone/src/presentation/state.dart';

import '../../../../config/themes/color.dart';

class MySliverPersitentHeader extends SliverPersistentHeaderDelegate {
  final TabController tabController;
  final double maxSize;
  final double minSize;
  MySliverPersitentHeader(
      {required this.tabController,
      required this.maxSize,
      required this.minSize});
  final profileTabBar = [
    text.allPost,
    text.private,
    text.saved,
  ];
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(
      color: colorGrey.shade100,
      child: TabBar(
        unselectedLabelColor: colorGrey,
        controller: tabController,
        dividerColor: Colors.transparent,
        tabs: List.generate(
            profileTabBar.length,
            (index) => Tab(
                  text: profileTabBar[index],
                )),
      ),
    );
  }

  @override
  double get maxExtent => maxSize;

  @override
  double get minExtent => minSize;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
