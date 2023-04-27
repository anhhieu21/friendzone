import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/common/constants/list_img_fake.dart';
import 'package:friendzone/presentation/routes/path.dart';
import 'package:friendzone/presentation/views/profile/cubit/myaccount/my_account_cubit.dart';
import 'package:friendzone/presentation/views/widgets/avatar_profile.dart';
import 'package:friendzone/presentation/views/widgets/background_profile.dart';
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
    return BlocBuilder<MyAccountCubit, MyAccountState?>(
        builder: (context, state) {
      if (state is MyAccountInfo) {
        final user = state.user;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(children: [
              SizedBox(height: 140 + size.width / 7.5 - 16.0),
              BackgroundProfile(
                url: user.background,
                width: size.width,
                height: 140,
              ),
              Positioned(
                bottom: 0,
                left: 16.0,
                child: AvatarProfile(
                  url: user.avartar,
                  radius: size.width / 7.5,
                ),
              )
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                          onPressed: () => GoRouter.of(context)
                              .push('/${RoutePath.updateProfile}', extra: user),
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
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
            ),
          ],
        );
      }
      return const SizedBox();
    });
  }
}
