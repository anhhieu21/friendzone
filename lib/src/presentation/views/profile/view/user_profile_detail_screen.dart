import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/domain/models/user_model.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/presentation/view.dart';
import 'package:friendzone/src/presentation/views/profile/widgets/header_profile.dart';
import 'package:friendzone/src/presentation/views/profile/widgets/my_bottom_appbar.dart';
import 'package:friendzone/src/utils.dart';

class ProfileDetailScreen extends StatefulWidget {
  final String id;
  const ProfileDetailScreen({super.key, required this.id});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  @override
  void initState() {
    BlocProvider.of<UserPreviewCubit>(context, listen: false)
        .loadInitialData(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocBuilder<UserPreviewCubit, UserpreviewState>(
        buildWhen: (previous, current) {
          if (current is LoadingUserState || current is UserDataState) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          final isFollowed = state is CheckFollowState ? state.isFollow : false;
          if (state is LoadingUserState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UserDataState) {
            final listPost = state.post;
            return NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    centerTitle: false,
                    pinned: false,
                    stretch: true,
                    collapsedHeight: kHeightAppBar,
                    flexibleSpace: HeaderProfile(
                      user: state.user,
                      isViewer: true,
                    ),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(kAppBarBottomSize),
                      child: BottomToolBar(
                        user: state.user,
                        isFollowed: isFollowed,
                        callback: isFollowed
                            ? (user) {}
                            : (user) => _follow(context, state.user, user),
                      ),
                    ),
                  ),
                ];
              },
              body: ListView.builder(
                  itemCount: listPost.length,
                  itemBuilder: (context, index) {
                    final item = listPost[index];
                    return PostItem(
                      item: item,
                      isPreviewUser: true,
                    );
                  }),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  _follow(BuildContext context, UserModel user, UserModel me) {
    BlocProvider.of<UserPreviewCubit>(context, listen: false)
        .followUser(user, me);
  }
}
