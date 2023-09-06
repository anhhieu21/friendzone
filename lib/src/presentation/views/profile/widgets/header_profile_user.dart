import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/presentation/shared.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/utils.dart';

import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'info_view.dart';
import 'show_follower.dart';

const expandedHeight = 280.0;
const heightBackground = expandedHeight / 2 + kToolbarHeight;

class HeaderProfileUser extends StatefulWidget {
  final Size size;
  final UserModel? user;

  const HeaderProfileUser({super.key, required this.size, this.user});

  @override
  State<HeaderProfileUser> createState() => _HeaderProfileUserState();
}

class _HeaderProfileUserState extends State<HeaderProfileUser>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  _follow(BuildContext context, UserModel? user) {
    BlocProvider.of<UserPreviewCubit>(context, listen: false)
        .followUser(widget.user!, user!);
  }

  @override
  Widget build(BuildContext context) {
    final radiusAvatar = widget.size.width / 7.5;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(children: [
          SizedBox(height: heightBackground + radiusAvatar),
          BackgroundProfile(
            url: widget.user?.background ?? urlAvatar,
            width: widget.size.width,
            height: heightBackground,
            isViewer: true,
          ),
          Positioned(
            bottom: 0,
            left: 16.0,
            child: AvatarProfile(
              url: widget.user?.avartar ?? urlAvatar,
              radius: radiusAvatar,
              isViewer: true,
            ),
          )
        ]),
        Expanded(
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _bodyHeader(context),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: BlocBuilder<UserPreviewCubit, UserpreviewState>(
                    builder: (context, state) {
                      final isFollowed =
                          state is CheckFollowState ? state.isFollow : false;
                      return BlocSelector<MyAccountCubit, MyAccountState,
                          UserModel?>(
                        selector: (state) {
                          if (state is MyDataState) return state.user;
                          return null;
                        },
                        builder: (_, user) {
                          return ElevatedButton(
                              onPressed: isFollowed
                                  ? () {}
                                  : () => _follow(context, user),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorBlue.shade500,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(isFollowed
                                      ? Ionicons.person_remove
                                      : Ionicons.person_add),
                                  Text(
                                    isFollowed ? 'Huỷ theo dõi' : 'Theo dõi',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ));
                        },
                      );
                    },
                  ),
                ),
                IconButton(
                    onPressed: () => context.pushNamed(
                        Formatter.nameRoute(RoutePath.conversentation),
                        extra: widget.user),
                    style: IconButton.styleFrom(
                      backgroundColor: colorGrey.shade300,
                    ),
                    icon: Icon(
                      Ionicons.chatbubble,
                      color: colorBlue.shade500,
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _bodyHeader(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      Formatter.emailtoDisplayName(widget.user?.name ?? ''),
                      style: textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Flutter is the future',
                      style: textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InforView(
                value: widget.user!.follower.toString(),
                label: text.followers,
                callback: () {
                  BlocProvider.of<UserPreviewCubit>(context, listen: false)
                      .getListFollower(widget.user!.idUser);
                  _showFollower(context);
                },
              ),
              const SizedBox(width: 12),
              InforView(
                value: widget.user!.following.toString(),
                label: text.following,
                callback: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  _showFollower(BuildContext context) {
    final size = MediaQuery.of(context).size;
    showBottomSheet(
        context: context,
        backgroundColor: colorWhite.withOpacity(0.98),
        constraints: BoxConstraints(maxHeight: size.height * 0.8),
        builder: (_) => const ShowFollower());
  }
}
