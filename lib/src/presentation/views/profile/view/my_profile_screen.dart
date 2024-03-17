import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/presentation/view.dart';
import 'package:friendzone/src/presentation/views/profile/widgets/header_profile.dart';
import 'package:friendzone/src/presentation/views/profile/widgets/my_bottom_appbar.dart';
import 'package:friendzone/src/utils.dart';
import 'package:go_router/go_router.dart';

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
  void dispose() {
    _tabController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return BlocBuilder<MyAccountCubit, MyAccountState>(
      buildWhen: (previous, current) {
        if (current is MyDataState) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        return NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              if (state is MyDataState)
                SliverAppBar(
                  centerTitle: false,
                  pinned: false,
                  stretch: true,
                  toolbarHeight: kHeightAppBar,
                  flexibleSpace: SizedBox(
                    width: size.width,
                    child: BlocListener<UpdateProfileCubit, UpdateProfileState>(
                      listener: (_, state) {
                        if (state is UpdateProfileChoseImage) {
                          if (state.isUpdateBackground) {
                            context.pushNamed(RoutePath.routeName(
                                RoutePath.updateBackground));
                          }
                        }
                      },
                      child: HeaderProfile(
                        user: state.user,
                        callback: () => _choseImage(context),
                      ),
                    ),
                  ),
                  forceElevated: innerBoxIsScrolled,
                  bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(kAppBarBottomSize),
                      child: MyBottomAppBar(user: state.user)),
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
                      TabMyPosts(size: size, listPost: listPostPublic),
                      TabMyPosts(size: size, listPost: listPostPrivate),
                      TabPostSave(listPost: listPostSave)
                    ]);
              }
              return const SizedBox();
            },
          ),
        );
      },
    );
  }

  _choseImage(BuildContext context) {
    BlocProvider.of<UpdateProfileCubit>(context)
        .choseImage(isUpdateBackground: true);
  }
}
