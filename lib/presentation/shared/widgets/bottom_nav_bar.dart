import 'package:flutter/material.dart';
import 'package:friendzone/presentation/themes/color.dart';

import '../../../data/models/menu.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final listNav = menuBottomNavBar.map((e) => Menu.fromMap(e)).toList();

    return Container(
      decoration: const BoxDecoration(color: colorWhite),
      padding: const EdgeInsets.only(
          left: 18.0, right: 18.0, bottom: 24.0, top: 16.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: listNav
              .map(
                (e) => Icon(e.iconData),
              )
              .toList()),
    );
  }
}
