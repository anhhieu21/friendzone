import 'package:flutter/material.dart';

import 'list_follower.dart';
import 'list_following.dart';

class ShowFollower extends StatefulWidget {
  const ShowFollower({super.key});

  @override
  State<ShowFollower> createState() => _ShowFollowerState();
}

class _ShowFollowerState extends State<ShowFollower>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            controller: tabController,
            dividerColor: Colors.transparent,
            tabs: ['follower', 'following']
                .map((e) => Tab(
                      text: e,
                    ))
                .toList()),
        Expanded(
            child: TabBarView(controller: tabController, children: const [
          ListFollower(),
          ListFollowing(),
        ]))
      ],
    );
  }
}
