import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/common/extentions/size_extention.dart';
import 'package:friendzone/presentation/shared/bloc/auth/auth_bloc.dart';

import 'package:friendzone/presentation/routes/path.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:friendzone/presentation/views/profile/view/widgets/header_profile.dart';
import 'package:friendzone/presentation/views/profile/view/widgets/my_posts.dart';
import 'package:go_router/go_router.dart';

const expandedHeight = 180.0;
const collapsedHeight = 120.0;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = SizeEx(context).screenSize;
    return SafeArea(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            GoRouter.of(context).replace(RoutePath.signin);
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: false,
              pinned: false,
              stretch: true,
              toolbarHeight: 280,
              flexibleSpace: SizedBox(
                width: size.width,
                child: HeaderProfile(size: size),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: MySliverPersitentHeader(
                tabController: _tabController,
                maxSize: 40,
                minSize: 40,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: size.height + 160,
                child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [
                      MyPosts(size: size),
                      MyPosts(size: size),
                      MyPosts(size: size)
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MySliverPersitentHeader extends SliverPersistentHeaderDelegate {
  final TabController tabController;
  final double maxSize;
  final double minSize;
  MySliverPersitentHeader(
      {required this.tabController,
      required this.maxSize,
      required this.minSize});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    List<String> myTabs = [
      'Tất cả bài viết',
      'Chỉ mình tôi',
      'Lưu trữ',
    ];
    return ColoredBox(
      color: colorGrey.shade100,
      child: TabBar(
        unselectedLabelColor: colorGrey,
        controller: tabController,
        dividerColor: Colors.transparent,
        tabs: List.generate(
            myTabs.length,
            (index) => Tab(
                  text: myTabs[index],
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
