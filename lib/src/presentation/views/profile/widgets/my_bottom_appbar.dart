import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/core/utils/constants/gap.dart';
import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/presentation/view.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class MyBottomAppBar extends StatelessWidget {
  final UserModel user;
  const MyBottomAppBar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Gap.s),
          child: BodyHeaderProfile(
            user: user,
            action: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton.tonal(
                  onPressed: () => context.pushNamed(
                      RoutePath.routeName(RoutePath.updateProfile),
                      extra: user),
                  child: Text(
                    text.editProfile,
                    maxLines: 1,
                  ),
                ),
                const MenuDrop()
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InforView(
              value: user.follower.toString(),
              label: text.followers,
              callback: () async {
                BlocProvider.of<UserPreviewCubit>(context, listen: false)
                    .getListFollower(user.idUser);
                _showFollower(context);
              },
            ),
            InforView(
              value: user.following.toString(),
              label: text.following,
              callback: () async {
                BlocProvider.of<UserPreviewCubit>(context, listen: false)
                    .getListFollower(user.idUser);
                _showFollower(context);
              },
            ),
          ],
        ),
      ],
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

class BottomToolBar extends StatelessWidget {
  final UserModel user;
  final bool isFollowed;
  final Function(UserModel user) callback;
  const BottomToolBar(
      {super.key,
      required this.user,
      required this.isFollowed,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Gap.m),
      child: Column(
        children: [
          BodyHeaderProfile(
            user: user,
            action: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocSelector<MyAccountCubit, MyAccountState, UserModel?>(
                  selector: (myState) {
                    if (myState is MyDataState) {
                      return myState.user;
                    }
                    return null;
                  },
                  builder: (_, user) {
                    return FilledButton.tonal(
                      onPressed: () => callback(user!),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(isFollowed
                              ? Ionicons.person_remove
                              : Ionicons.person_add),
                          Text(
                            isFollowed ? 'Huỷ theo dõi' : 'Theo dõi',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                IconButton.filledTonal(
                  onPressed: () => context.pushNamed(
                      RoutePath.routeName(RoutePath.conversentation),
                      extra: user),
                  icon: const Icon(
                    Ionicons.chatbubble,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InforView(
                value: user.follower.toString(),
                label: text.followers,
                callback: () async {},
              ),
              InforView(
                value: user.following.toString(),
                label: text.following,
                callback: () async {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
