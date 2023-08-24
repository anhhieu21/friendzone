import 'package:flutter/material.dart';
import 'package:friendzone/common/constants/list_img_fake.dart';
import 'package:friendzone/presentation/shared/widgets/custom_app_bar.dart';
import 'package:friendzone/presentation/themes/color.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/data.dart';
import 'package:friendzone/presentation/routes/path.dart';
import 'package:friendzone/presentation/shared.dart';
import 'package:friendzone/presentation/utils/formatter.dart';
import 'package:friendzone/state/profile/myaccount/my_account_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class AppBarHome extends StatelessWidget {
  final ScrollController scrollController;
  const AppBarHome({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return CustomSliverAppBar(
      scrollController: scrollController,
      expandedHeight: 120,
      collapsedHeight: 60.0,
      flexTitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: BlocSelector<MyAccountCubit, MyAccountState, UserModel?>(
              selector: (state) => state is MyDataState ? state.user : null,
              builder: (context, user) => CircleAvatar(
                radius: 20,
                backgroundImage: CachedNetworkImageProvider(
                  user?.avartar ?? urlAvatar,
                ),
              ),
            ),
          ),
          Expanded(
            child: OnTapEffect(
              onTap: () {
                context.pushNamed(Formatter.nameRoute((RoutePath.writepost)));
              },
              radius: 16,
              child: Container(
                height: 40,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: colorWhite),
                child: const Text('Today,how do you feel ?'),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                context.pushNamed(Formatter.nameRoute((RoutePath.writepost)));
              },
              icon: Icon(
                Ionicons.create_outline,
                color: colorGrey.shade700,
              )),
        ],
      ),
      title: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Friend Zone',
                style: TextStyle(color: colorPinkButton, fontSize: 20),
              ),
              Text(
                'Good morning ',
                style: TextStyle(color: colorBlack.withOpacity(0.7)),
              ),
            ],
          ),
        ],
      ),
      action: [
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
