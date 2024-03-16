import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/data.dart';
import 'package:friendzone/src/data/services/fcm.dart';
import 'package:friendzone/src/data/services/notification.dart';
import 'package:friendzone/src/presentation/state.dart';

import 'package:friendzone/src/presentation/view.dart';
import 'package:friendzone/src/presentation/views/profile/widgets/nav_bar.dart';
import 'package:ionicons/ionicons.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  List<Widget> _listView = [];
  StreamController<int> navStream = StreamController<int>();
  List<NavBarItemData> menuBottomNavBar = [];

  @override
  void initState() {
    final remoteConfig = FirebaseRemoteConfig.instance;
    remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    menuBottomNavBar = [
      NavBarItemData(text.home, Ionicons.home, 110, const Color(0xff01b87d)),
      NavBarItemData(text.reels, Ionicons.albums, 110, const Color(0xff594ccf)),
      NavBarItemData(
          text.friend, Ionicons.people, 115, const Color(0xff09a8d9)),
      NavBarItemData(
          text.profile, Ionicons.person_circle, 100, const Color(0xffcf4c7a)),
    ];
    _tabController =
        TabController(length: menuBottomNavBar.length, vsync: this);
    _listView = [
      const HomeScreen(),
      const ReelsScreen(),
      const FriendZoneScreen(),
      const ProfileScreen()
    ];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<AllPostCubit>(context).getAllPost();
    });
    AppNotification.instance
        .initialize(flutterLocalNotificationsPlugin)
        .then((value) => AppNotification.instance.listenMessage());
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
          return NavBar(
              currentIndex: snapshot.data ?? _tabController.index,
              itemTapped: (value) {
                _tabController.index = value;
                navStream.sink.add(value);
              },
              items: menuBottomNavBar);
        },
      ),
    );
  }
}
