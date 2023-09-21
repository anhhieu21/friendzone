import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/domain/models/user_model.dart';
import 'package:friendzone/src/presentation/shared.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/utils.dart';
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
                context.pushNamed(RoutePath.routeName(RoutePath.writepost));
              },
              radius: 16,
              child: Container(
                height: 40,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Theme.of(context).cardColor),
                child: Text(text.welcome),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                context.pushNamed(RoutePath.routeName(
                    RoutePath.routeName(RoutePath.writepost)));
              },
              icon: Icon(
                Ionicons.create_outline,
                color: colorGrey.shade700,
              )),
        ],
      ),
      title: const Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Friend Zone', style: TextStyle(fontSize: 20)),
              Text('Good morning '),
            ],
          ),
        ],
      ),
      action: [
        // IconButton(
        //     onPressed: () {},
        //     icon: Stack(
        //       children: [
        //         Icon(
        //           Ionicons.notifications_outline,
        //           color: colorGrey.shade700,
        //         ),
        //         Positioned(
        //             top: 0,
        //             right: 0,
        //             child: Icon(
        //               Ionicons.ellipse,
        //               size: 10,
        //               color: colorRed.shade400,
        //             )),
        //       ],
        //     ))
        IconButton(
            onPressed: () =>
                context.pushNamed(RoutePath.routeName(RoutePath.chat)),
            icon: Stack(
              children: [
                Icon(
                  Ionicons.chatbubble,
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
