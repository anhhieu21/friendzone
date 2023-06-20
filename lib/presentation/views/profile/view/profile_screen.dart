import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/common/extentions/size_extention.dart';

import 'package:friendzone/presentation/themes/color.dart';
import 'package:friendzone/presentation/view.dart';
import 'package:friendzone/data.dart' hide MyPosts;
import 'package:friendzone/state/profile/myaccount/my_account_cubit.dart';


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
  late ScrollController scrollController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = SizeEx(context).screenSize;
    return SafeArea(
      // child: BlocListener<AuthBloc, AuthState>(
      //   listener: (context, state) {
      //     if (state is UnAuthenticated) {
      //       context.replace(RoutePath.splash);
      //     }
      //   },
      child: BlocBuilder<MyAccountCubit, MyAccountState>(
        builder: (context, state) {
          final listPost = state.myPostsPublic ?? [];
          return NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  centerTitle: false,
                  pinned: false,
                  stretch: true,
                  toolbarHeight: 280,
                  flexibleSpace: SizedBox(
                    width: size.width,
                    child: HeaderProfile(
                      size: size,
                      user: state.user,
                    ),
                  ),
                  forceElevated: innerBoxIsScrolled,
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
              ];
            },
            body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  MyPosts(size: size, listPost: listPost),
                  MyPosts(size: size, listPost: listPost),
                  MyPosts(size: size, listPost: listPost)
                ]),
          );
        },
      ),
      // ),
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
