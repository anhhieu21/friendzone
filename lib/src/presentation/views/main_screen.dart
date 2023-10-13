import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/data.dart';
import 'package:friendzone/src/data/repositories/weather_repository_impl.dart';
import 'package:friendzone/src/data/services/fcm.dart';
import 'package:friendzone/src/data/services/notification.dart';
import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/presentation/state.dart';

import 'package:friendzone/src/presentation/view.dart';
import 'package:friendzone/src/utils.dart';
import 'package:ionicons/ionicons.dart';

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
    final remoteConfig = FirebaseRemoteConfig.instance;
    WeatherRepositoryImpl.keyApiWeather =
        remoteConfig.getString(kKeyApiWeather);
    final menuBottomNavBar = [
      {'title': text.home, 'iconData': Ionicons.home},
      {'title': text.reels, 'iconData': Ionicons.albums},
      {'title': text.friend, 'iconData': Ionicons.people},
      {'title': text.profile, 'iconData': Ionicons.person_circle},
    ];

    listNav = menuBottomNavBar.map((e) => Menu.fromMap(e)).toList();
    _tabController = TabController(length: listNav.length, vsync: this);
    _listView = [
      const HomeScreen(),
      const ReelsScreen(),
      FriendZoneScreen(),
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
