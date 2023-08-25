import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/data/models/menu.dart';
import 'package:friendzone/presentation/state.dart';
import 'package:friendzone/presentation/views/view.dart';
import 'package:ionicons/ionicons.dart';

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
  StreamController<int> navStream = StreamController<int>();

  @override
  void initState() {
    final menuBottomNavBar = [
      {'title': text.home, 'iconData': Ionicons.home},
      {'title': text.reels, 'iconData': Ionicons.albums},
      {'title': text.chat, 'iconData': Ionicons.chatbubble},
      {'title': text.friend, 'iconData': Ionicons.people},
      {'title': text.profile, 'iconData': Ionicons.person_circle},
    ];

    listNav = menuBottomNavBar.map((e) => Menu.fromMap(e)).toList();
    _tabController = TabController(length: listNav.length, vsync: this);
    _listView = [
      const HomeScreen(),
      const ReelsScreen(),
      const ChatsScreen(),
      FriendZoneScreen(),
      const ProfileScreen()
    ];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<AllPostCubit>(context).getAllPost();
      BlocProvider.of<FeedCubit>(context).getFeeds();
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
      bottomNavigationBar: StreamBuilder<int>(
          stream: navStream.stream,
          builder: (context, snapshot) {
            return BottomNavigationBar(
                currentIndex: snapshot.data ?? _tabController.index,
                onTap: (value) {
                  _tabController.index = value;
                  navStream.sink.add(value);
                },
                items: listNav
                    .map((e) => BottomNavigationBarItem(
                        icon: Icon(e.iconData), label: e.title))
                    .toList());
          }),
    );
  }
}
