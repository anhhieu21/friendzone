import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/presentation/view.dart';
import 'package:friendzone/src/utils.dart';

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
      child: BlocBuilder<MyAccountCubit, MyAccountState>(
        buildWhen: (previous, current) {
          if (current is MyDataState) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          return NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                if (state is MyDataState)
                  SliverAppBar(
                    centerTitle: false,
                    pinned: false,
                    stretch: true,
                    toolbarHeight: 285,
                    flexibleSpace: SizedBox(
                      width: size.width,
                      child: HeaderMyProfile(
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
            body: Builder(
              builder: (_) {
                if (state is MyDataState) {
                  final listPostPublic = state.myPostsPublic;
                  final listPostPrivate = state.myPostsPrivate;
                  final listPostSave = state.myPostsSave;
                  return TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        MyPosts(size: size, listPost: listPostPublic),
                        MyPosts(size: size, listPost: listPostPrivate),
                        TabPostSave(listPost: listPostSave)
                      ]);
                }
                return const SizedBox();
              },
            ),
          );
        },
      ),
    );
  }
}
