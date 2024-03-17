import 'package:flutter/material.dart';
import 'package:friendzone/src/core/utils/constants/gap.dart';
import 'package:friendzone/src/presentation/shared.dart';
import 'package:friendzone/src/utils.dart';

import '../../../../domain/models/user_model.dart';

class HeaderProfile extends StatelessWidget {
  final UserModel user;
  final Function()? callback;
  final bool isViewer;
  const HeaderProfile(
      {super.key, required this.user, this.callback, this.isViewer = false});

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
            BackgroundProfile(
              url: user.background,
              width: size.width,
              height: kHeightCover,
              callback: callback,
              isViewer: isViewer,
            ),
            Positioned(
              bottom: 0,
              left: Gap.m,
              child: AvatarProfile(
                url: user.avartar,
                radius: radiusAvatar,
                isViewer: isViewer,
              ),
            )
          ],
        ),
      ],
    );
  }
}
