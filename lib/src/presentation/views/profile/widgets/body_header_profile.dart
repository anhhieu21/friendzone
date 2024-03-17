import 'package:flutter/material.dart';
import 'package:friendzone/src/utils.dart';

import '../../../../domain/models/user_model.dart';

class BodyHeaderProfile extends StatelessWidget {
  final UserModel user;
  final Widget action;
  const BodyHeaderProfile(
      {super.key, required this.user, required this.action});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        action,
      ],
    );
  }
}
