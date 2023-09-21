import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:friendzone/src/domain/models/user_model.dart';

class ItemFriend extends StatelessWidget {
  final UserModel user;
  const ItemFriend({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: CachedNetworkImageProvider(user.avartar),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            user.name,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
