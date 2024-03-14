import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/core/config/routes/path.dart';
import 'package:friendzone/src/core/config/themes/color.dart';
import 'package:friendzone/src/presentation/shared.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/presentation/view.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/models/user_model.dart';

class HeaderMyProfile extends StatelessWidget {
  final Size size;
  final UserModel user;
  const HeaderMyProfile({super.key, required this.size, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(children: [
          SizedBox(height: 140 + size.width / 7.5 - 16.0),
          BlocListener<UpdateProfileCubit, UpdateProfileState>(
            listener: (_, state) {
              if (state is UpdateProfileChoseImage) {
                if (state.isUpdateBackground) {
                  context.pushNamed(
                      RoutePath.routeName(RoutePath.updateBackground));
                }
              }
            },
            child: BackgroundProfile(
              url: user.background,
              width: size.width,
              height: 140,
              callback: () => _choseImage(context),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 16.0,
            child: AvatarProfile(
              url: user.avartar,
              radius: size.width / 7.5,
            ),
          )
        ]),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: BodyHeaderProfile(user: user),
        ),
        Expanded(
          child: Row(
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
        ),
      ],
    );
  }

  _showFollower(BuildContext context) async {
    final size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        backgroundColor: colorWhite.withOpacity(0.98),
        constraints: BoxConstraints(maxHeight: size.height * 0.8),
        builder: (_) => const ShowFollower());
  }

  _choseImage(BuildContext context) {
    BlocProvider.of<UpdateProfileCubit>(context)
        .choseImage(isUpdateBackground: true);
  }
}
