import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friendzone/common/extentions/size_extention.dart';
import 'package:friendzone/presentation/routes/path.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:friendzone/presentation/views/profile/view/widgets/header_profile.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    final size = BuildContextX(context).screenSize;
    return AppBar(
      title: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (context, snapshot) {
            final user = snapshot.data;
            return Row(
              children: [
                CachedNetworkImage(
                    imageUrl: user?.photoURL ?? urlAvatar,
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: size.width / 18,
                          backgroundImage: imageProvider,
                        )),
                const SizedBox(
                  width: 6,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Friend Zone',
                      style: TextStyle(color: colorPinkButton, fontSize: 20),
                    ),
                    Text(
                      'Good morning ${user?.displayName}',
                      style: TextStyle(color: colorBlack.withOpacity(0.7)),
                    ),
                  ],
                ),
              ],
            );
          }),
      actions: [
        IconButton(
            onPressed: () {
              context.go('/${RoutePath.writepost}');
            },
            icon: Icon(
              Ionicons.create_outline,
              color: colorGrey.shade700,
            )),
        IconButton(
            onPressed: () {},
            icon: Stack(
              children: [
                Icon(
                  Ionicons.notifications_outline,
                  color: colorGrey.shade700,
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: Icon(
                      Ionicons.ellipse,
                      size: 10,
                      color: colorRed.shade400,
                    )),
              ],
            ))
      ],
    );
  }
}
