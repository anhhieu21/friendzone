import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friendzone/presentation/routes/path.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:friendzone/presentation/views/widgets/ontap_effect.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../common/constants/list_img_fake.dart';

const expandedHeight = 120.0;
const collapsedHeight = 60.0;

class CustomSliverAppBar extends StatefulWidget {
  final ScrollController scrollController;
  const CustomSliverAppBar({super.key, required this.scrollController});

  @override
  State<CustomSliverAppBar> createState() => _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends State<CustomSliverAppBar> {
  final StreamController<bool> _streamController =
      StreamController<bool>.broadcast();
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      _streamController.sink.add(widget.scrollController.position.pixels >= 30);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          return SliverAppBar(
            pinned: true,
            stretch: true,
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
                      'Good morning ${user?.displayName}',
                      style: TextStyle(color: colorBlack.withOpacity(0.7)),
                    ),
                  ],
                ),
              ],
            ),
            expandedHeight: expandedHeight,
            flexibleSpace: StreamBuilder<bool>(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  final isExpand = snapshot.data ?? false;
                  return AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isExpand ? 0 : 1,
                    child: FlexibleSpaceBar(
                      expandedTitleScale: 1.2,
                      centerTitle: true,
                      titlePadding: const EdgeInsets.only(top: 8.0),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CachedNetworkImage(
                                imageUrl: user?.photoURL ?? urlAvatar,
                                fit: BoxFit.cover,
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage: imageProvider,
                                    )),
                          ),
                          Expanded(
                            child: OnTapEffect(
                              onTap: () {},
                              radius: 16,
                              child: Container(
                                height: 40,
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.only(left: 8.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    color: colorGrey.withOpacity(0.5)),
                                child: const Text('Today,how do you feel ?'),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                context.go('/${RoutePath.writepost}');
                              },
                              icon: Icon(
                                Ionicons.create_outline,
                                color: colorGrey.shade700,
                              )),
                        ],
                      ),
                    ),
                  );
                }),
            actions: [
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
        });
  }
}
