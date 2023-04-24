import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:friendzone/common/constants/list_img_fake.dart';
import 'package:friendzone/presentation/routes/path.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friendzone/presentation/views/profile/view/widgets/info_view.dart';

import 'menu_more.dart';


class HeaderProfile extends StatelessWidget {
  final Size size;
  const HeaderProfile({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CachedNetworkImage(
                      imageUrl: user?.photoURL ?? urlAvatar,
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                            radius: size.width / 8,
                            backgroundImage: imageProvider,
                          )),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            InforView(
                              value: '100+',
                              label: 'Connections',
                            ),
                            InforView(
                              value: '688',
                              label: 'Followers',
                            ),
                            InforView(
                              value: '178',
                              label: 'Following',
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                                onPressed: () => GoRouter.of(context).push(
                                    '/${RoutePath.updateProfile}',
                                    extra: user),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: colorGrey.shade300),
                                icon: Icon(Ionicons.key_outline,
                                    color: colorBlue.shade500),
                                label: Text(
                                  'Chỉnh sửa thông tin',
                                  style: TextStyle(
                                      color: colorBlue.shade500,
                                      fontWeight: FontWeight.w600),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            const MenuDrop()
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                user?.displayName ?? 'User name',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const Text(
                'Flutter is the future',
                style: TextStyle(
                  fontSize: 14,
                ),
              )
            ],
          );
        });
  }
}
