import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/core/config/routes/path.dart';
import 'package:friendzone/src/core/utils/constants/gap.dart';
import 'package:friendzone/src/presentation/shared.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/utils.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/models/user_model.dart';

class HeaderMyProfile extends StatelessWidget {
  final UserModel user;
  const HeaderMyProfile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    final radiusAvatar = size.width / 8;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            SizedBox(height: kHeightCover + radiusAvatar),
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
                height: kHeightCover,
                callback: () => _choseImage(context),
              ),
            ),
            Positioned(
              bottom: 0,
              left: Gap.m,
              child: AvatarProfile(
                url: user.avartar,
                radius: radiusAvatar,
              ),
            )
          ],
        ),
      ],
    );
  }

  _choseImage(BuildContext context) {
    BlocProvider.of<UpdateProfileCubit>(context)
        .choseImage(isUpdateBackground: true);
  }
}
