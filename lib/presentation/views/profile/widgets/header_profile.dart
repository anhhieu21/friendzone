import 'package:flutter/material.dart';
import 'package:friendzone/common/constants/list_img_fake.dart';
import 'package:friendzone/data.dart';
import 'package:friendzone/presentation/routes/path.dart';
import 'package:friendzone/presentation/shared.dart';
import 'package:go_router/go_router.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:friendzone/presentation/views/profile/widgets/info_view.dart';
import '../../../utils/formatter.dart';
import 'menu_more.dart';

class HeaderProfile extends StatelessWidget {
  final Size size;
  final UserModel? user;
  const HeaderProfile({super.key, required this.size, this.user});

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
          ),
          Positioned(
            bottom: 0,
            left: 16.0,
            child: AvatarProfile(
              url: user?.avartar ?? urlAvatar,
              radius: size.width / 7.5,
            ),
          )
        ]),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: _bodyHeader(context),
        ),
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
    );
  }

  Widget _bodyHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Formatter.emailtoDisplayName(user?.name ?? ''),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const Text(
                  'Flutter is the future',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            )),
        Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () => context.pushNamed(
                          Formatter.nameRoute(RoutePath.updateProfile),
                          extra: user),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: colorGrey.shade300),
                      child: Text(
                        'Chỉnh sửa thông tin',
                        style: TextStyle(
                            color: colorBlue.shade500,
                            fontWeight: FontWeight.w600),
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                const MenuDrop()
              ],
            )),
      ],
    );
  }
}