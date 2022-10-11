import 'package:flutter/material.dart';
import 'package:friendzone/common/extentions/size_extention.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:friendzone/presentation/views/profile/view/widgets/header_profile.dart';
import 'package:friendzone/presentation/views/profile/view/widgets/my_posts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  List<String> myTabs = [
    'Tất cả bài viết',
    'Chỉ mình tôi',
    'Lưu trữ',
  ];
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = BuildContextX(context).screenSize;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderProfile(size: size),
            const SizedBox(
              height: 10,
            ),
            TabBar(
                unselectedLabelColor: colorGrey,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: colorBlack.withOpacity(0.8)),
                controller: _tabController,
                tabs: List.generate(
                    myTabs.length,
                    (index) => Tab(
                          height: 30,
                          text: myTabs[index],
                        ))),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                MyPosts(size: size),
                MyPosts(size: size),
                MyPosts(size: size)
              ]),
            )
          ],
        ),
      ),
    ));
  }
}
