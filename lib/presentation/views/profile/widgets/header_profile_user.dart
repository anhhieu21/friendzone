import 'package:flutter/material.dart';
import 'package:friendzone/common/constants/list_img_fake.dart';
import 'package:friendzone/data.dart';
import 'package:friendzone/presentation/routes/path.dart';
import 'package:friendzone/presentation/shared.dart';
import 'package:go_router/go_router.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:ionicons/ionicons.dart';
import '../../../utils/formatter.dart';
import 'info_view.dart';
import 'menu_more.dart';

class HeaderProfileUser extends StatelessWidget {
  final Size size;
  final UserModel? user;
  const HeaderProfileUser({super.key, required this.size, this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(children: [
          SizedBox(height: 140 + size.width / 7.5 - 16.0),
          BackgroundProfile(
            url: user?.background ?? urlAvatar,
            width: size.width,
            height: 140,
            isViewer: true,
          ),
          Positioned(
            bottom: 0,
            left: 16.0,
            child: AvatarProfile(
              url: user?.avartar ?? urlAvatar,
              radius: size.width / 7.5,
              isViewer: true,
            ),
          )
        ]),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: _bodyHeader(context),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: () => context.pushNamed(
                        Formatter.nameRoute(RoutePath.updateProfile),
                        extra: user),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorBlue.shade500,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Ionicons.person_add),
                        Text(
                          'Theo dõi',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    )),
              ),
              IconButton(
                  onPressed: () => context.pushNamed(
                      Formatter.nameRoute(RoutePath.conversentation),
                      extra: user),
                  style: IconButton.styleFrom(
                    backgroundColor: colorGrey.shade300,
                  ),
                  icon: Icon(
                    Ionicons.chatbubble,
                    color: colorBlue.shade500,
                  )),
              const MenuDrop()
            ],
          ),
        ),
      ],
    );
  }

  Widget _bodyHeader(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final hobbies = [
      'Âm nhạc',
      'Game',
      'Đi dạo',
      'Cú đêm',
      'Không hút thuốc',
      'Chiêm tinh',
    ];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Formatter.emailtoDisplayName(user?.name ?? ''),
                      style: textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Flutter is the future',
                      style: textTheme.bodyLarge,
                    ),
                  ],
                )),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
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
            ),
          ],
        ),
        // Expanded(
        //   child: Row(
        //     children: hobbies
        //         .map((e) => Container(
        //               padding: const EdgeInsets.all(8.0),
        //               decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(16.0),
        //                   color: colorGrey.shade200),
        //               child: Text(e),
        //             ))
        //         .toList(),
        //   ),
        // )
      ],
    );
  }
}
