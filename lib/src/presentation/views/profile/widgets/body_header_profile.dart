import 'package:flutter/material.dart';
import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/utils.dart';

import 'package:go_router/go_router.dart';

import '../../../../domain/models/user_model.dart';
import 'menu_more.dart';

class BodyHeaderProfile extends StatelessWidget {
  final UserModel user;
  const BodyHeaderProfile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Formatter.emailtoDisplayName(user.name),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                user.bio ?? 'bio here',
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Row(
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
      ],
    );
  }
}
