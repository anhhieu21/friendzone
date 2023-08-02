import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/data.dart';
import 'package:friendzone/presentation/shared.dart';
import 'package:friendzone/state/profile/user/user_cubit.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:friendzone/presentation/views/profile/widgets/info_view.dart';
import 'body_header_profile.dart';
import 'show_follower.dart';

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
          BackgroundProfile(
            url: user.background,
            width: size.width,
            height: 140,
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
                label: 'Followers',
                callback: () async {
                  BlocProvider.of<UserPreviewCubit>(context, listen: false)
                      .getListFollower(user.idUser);
                  _showFollower(context);
                },
              ),
              InforView(
                value: user.following.toString(),
                label: 'Following',
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
    showBottomSheet(
        context: context,
        backgroundColor: colorWhite.withOpacity(0.98),
        constraints: BoxConstraints(maxHeight: size.height * 0.8),
        builder: (_) => const ShowFollower());
  }
}
