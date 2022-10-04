import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friendzone/presentation/views/profile/view/widgets/info_view.dart';
const urlAvatar =
    'https://images.unsplash.com/photo-1600486913747-55e5470d6f40?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80';

class HeaderProfile extends StatelessWidget {
  final Size size;
  const HeaderProfile({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: size.width / 8,
                    backgroundImage: const NetworkImage(urlAvatar),
                  ),
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
                                onPressed: () {},
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
                            IconButton(
                                onPressed: () {},
                                style: IconButton.styleFrom(
                                    backgroundColor: colorGrey.shade300),
                                icon: Icon(
                                  Ionicons.ellipsis_horizontal,
                                  color: colorBlue.shade500,
                                )),
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
                user?.email ?? 'User name',
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
