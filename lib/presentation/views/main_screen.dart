import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/data/models/menu.dart';
import 'package:friendzone/presentation/views/view.dart';
import 'package:friendzone/state/chat/chats_cubit.dart';
import 'package:friendzone/state/home/allpost/all_post_cubit.dart';
import 'package:friendzone/state/home/feed_cubit/new_feeds_cubit.dart';

import 'chats/view/chats_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  List<Menu> listNav = [];
  List<Widget> _listView = [];
  @override
  void initState() {
    listNav = menuBottomNavBar.map((e) => Menu.fromMap(e)).toList();
    _tabController = TabController(length: listNav.length, vsync: this);
    _listView = [
      const HomeScreen(),
      const ChatsScreen(),
      FriendZoneScreen(),
      const ProfileScreen()
    ];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<AllPostCubit>(context).getAllPost();
      BlocProvider.of<NewFeedsCubit>(context).getAllPost();
      BlocProvider.of<ChatsCubit>(context).getListConversation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: _listView,
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _tabController.index,
          onTap: (value) {
            _tabController.index = value;
            setState(() {});
          },
          items: listNav
              .map((e) => BottomNavigationBarItem(
                  icon: Icon(e.iconData), label: e.title))
              .toList()),
      // bottomNavigationBar: const BottomNavBar(),
    );
  }
}
