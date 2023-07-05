import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/common/constants/list_img_fake.dart';
import 'package:friendzone/data.dart';
import 'package:friendzone/presentation/routes/path.dart';
import 'package:friendzone/presentation/shared.dart';
import 'package:friendzone/state/profile/myaccount/my_account_cubit.dart';
import 'package:friendzone/state/profile/user/user_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:friendzone/presentation/views/profile/widgets/info_view.dart';
import '../../../utils/formatter.dart';
import 'menu_more.dart';
import 'show_follower.dart';

class HeaderProfile extends StatelessWidget {
  final Size size;
  const HeaderProfile({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MyAccountCubit, MyAccountState, UserModel?>(
      selector: (state) => state is MyDataState ? state.user : null,
      builder: (context, user) {
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
              child: _bodyHeader(context, user!),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InforView(
                  value: user.follower.toString(),
                  label: 'Followers',
                  callback: () async {
                    BlocProvider.of<UserPreviewCubit>(context, listen: false)
                        .getListFollower(user.idUser);
                    _showFollower(context);
                  },
                ),
                InforView(
                  value: user.following.toString(),
                  label: 'Following',
                  callback: () async {
                    BlocProvider.of<UserPreviewCubit>(context, listen: false)
                        .getListFollower(user.idUser);
                    _showFollower(context);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  _showFollower(BuildContext context) async {
    final size = MediaQuery.of(context).size;
    showBottomSheet(
        context: context,
        backgroundColor: colorWhite.withOpacity(0.98),
        constraints: BoxConstraints(maxHeight: size.height * 0.8),
        builder: (_) => const ShowFollower());
  }

  Widget _bodyHeader(BuildContext context, UserModel user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Formatter.emailtoDisplayName(user.name),
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
