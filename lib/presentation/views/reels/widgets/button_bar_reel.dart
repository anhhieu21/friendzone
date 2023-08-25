import 'package:flutter/material.dart';
import 'package:friendzone/data.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:ionicons/ionicons.dart';

const edge = 16.0;

class ButtonBarReel extends StatelessWidget {
  final Function(MenuReels value) onPressed;
  ButtonBarReel({super.key, required this.onPressed});
  final menu = <Menu>[
    Menu(title: '0', iconData: Ionicons.heart_outline, func: MenuReels.like),
    Menu(
        title: '0',
        iconData: Ionicons.chatbubble_outline,
        func: MenuReels.comment),
    Menu(
        title: 'Create',
        iconData: Ionicons.videocam_outline,
        func: MenuReels.create),
  ];

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: kBottomNavigationBarHeight + edge,
        right: edge,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: menu
              .map(
                (e) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  height: 35,
                  child: ElevatedButton.icon(
                      style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26.0)),
                          backgroundColor: colorGrey.withOpacity(0.4)),
                      onPressed: () => onPressed(e.func as MenuReels),
                      label: Text(e.title),
                      icon: Icon(e.iconData)),
                ),
              )
              .toList(),
        ));
  }
}
