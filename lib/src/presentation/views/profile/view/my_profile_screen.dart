import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/core/utils/constants/gap.dart';
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
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              if (state is MyDataState)
                SliverAppBar(
                  centerTitle: false,
                  pinned: false,
                  stretch: true,
                  toolbarHeight: kHeightAppBar,
                  flexibleSpace: SizedBox(
                    width: size.width,
                    child: HeaderMyProfile(
                      user: state.user,
                    ),
                  ),
                  forceElevated: innerBoxIsScrolled,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(kBottomSize),
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: Gap.s),
                          child: BodyHeaderProfile(user: state.user),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InforView(
                              value: state.user.follower.toString(),
                              label: text.followers,
                              callback: () async {
                                BlocProvider.of<UserPreviewCubit>(context,
                                        listen: false)
                                    .getListFollower(state.user.idUser);
                                _showFollower(context);
                              },
                            ),
                            InforView(
                              value: state.user.following.toString(),
                              label: text.following,
                              callback: () async {
                                BlocProvider.of<UserPreviewCubit>(context,
                                        listen: false)
                                    .getListFollower(state.user.idUser);
                                _showFollower(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
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

  _showFollower(BuildContext context) async {
    final size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        constraints: BoxConstraints(maxHeight: size.height * 0.8),
        builder: (_) => const ShowFollower());
  }
}
