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
            ElevatedButton(
                onPressed: () => context.pushNamed(
                    RoutePath.routeName(RoutePath.updateProfile),
                    extra: user),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    backgroundColor: colorGrey.shade300),
                child: Text(
                  text.editProfile,
                  maxLines: 1,
                  style: TextStyle(
                      color: colorBlue.shade500, fontWeight: FontWeight.w600),
                )),
            const SizedBox(
              width: 10,
            ),
            const MenuDrop()
          ],
        ),
      ],
    );
  }
}
