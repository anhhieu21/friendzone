import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/common/constants/list_img_fake.dart';
import 'package:friendzone/data.dart';
import 'package:friendzone/presentation/routes/path.dart';
import 'package:friendzone/presentation/shared.dart';
import 'package:friendzone/presentation/views/profile/widgets/show_follower.dart';
import 'package:friendzone/state.dart';
import 'package:friendzone/state/profile/user/user_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:ionicons/ionicons.dart';
import '../../../utils/formatter.dart';
import 'info_view.dart';
import 'menu_more.dart';

class HeaderProfileUser extends StatefulWidget {
  final Size size;
  final UserModel? user;
  const HeaderProfileUser({super.key, required this.size, this.user});

  @override
  State<HeaderProfileUser> createState() => _HeaderProfileUserState();
}

class _HeaderProfileUserState extends State<HeaderProfileUser>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  _follow(BuildContext context) {
    final state = BlocProvider.of<MyAccountCubit>(context, listen: false).state;
    BlocProvider.of<UserPreviewCubit>(context, listen: false)
        .followUser(widget.user!, state.user!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(children: [
          SizedBox(height: 140 + widget.size.width / 7.5 - 16.0),
          BackgroundProfile(
            url: widget.user?.background ?? urlAvatar,
            width: widget.size.width,
            height: 140,
            isViewer: true,
          ),
          Positioned(
            bottom: 0,
            left: 16.0,
            child: AvatarProfile(
              url: widget.user?.avartar ?? urlAvatar,
              radius: widget.size.width / 7.5,
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
                    onPressed: () => _follow(context),
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
                      extra: widget.user),
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

    // final hobbies = [
    //   'Âm nhạc',
    //   'Game',
    //   'Đi dạo',
    //   'Cú đêm',
    //   'Không hút thuốc',
    //   'Chiêm tinh',
    // ];
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
                      Formatter.emailtoDisplayName(widget.user?.name ?? ''),
                      style: textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Flutter is the future',
                      style: textTheme.bodyLarge,
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InforView(
                    value: widget.user!.follower.toString(),
                    label: 'Followers',
                    callback: () {
                      BlocProvider.of<UserPreviewCubit>(context, listen: false)
                          .getListFollower(widget.user!.idUser);
                      _showFollower(context);
                    },
                  ),
                  const SizedBox(width: 12),
                  InforView(
                    value: widget.user!.following.toString(),
                    label: 'Following',
                    callback: () {},
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

  _showFollower(BuildContext context) {
    final size = MediaQuery.of(context).size;
    showBottomSheet(
        context: context,
        backgroundColor: colorWhite.withOpacity(0.98),
        constraints: BoxConstraints(maxHeight: size.height * 0.8),
        builder: (_) => const ShowFollower());
  }
}
