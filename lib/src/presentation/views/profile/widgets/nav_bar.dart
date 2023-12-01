// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'nav_bar_item.dart';

class NavBarItemData {
  final String title;
  final IconData icon;
  final Color selectedColor;
  final double width;

  NavBarItemData(this.title, this.icon, this.width, this.selectedColor);
}

class NavBar extends StatelessWidget {
  final ValueChanged<int> itemTapped;
  final int currentIndex;
  final List<NavBarItemData> items;
  const NavBar({
    Key? key,
    required this.itemTapped,
    this.currentIndex = 0,
    required this.items,
  }) : super(key: key);
  NavBarItemData? get selectedItem =>
      currentIndex >= 0 && currentIndex < items.length
          ? items[currentIndex]
          : null;
  @override
  Widget build(BuildContext context) {
    List<Widget> buttonWidgets = items.map((data) {
      return NavbarButton(
          data: data,
          isSelected: data == selectedItem,
          onTap: () {
            var index = items.indexOf(data);
            itemTapped(index);
          });
    }).toList();
    final color = Theme.of(context).cardColor;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: color,
        boxShadow: const [
          BoxShadow(blurRadius: 16, color: Colors.black12),
          BoxShadow(blurRadius: 24, color: Colors.black12),
        ],
      ),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: buttonWidgets,
      ),
    );
  }
}

class ClippedView extends StatelessWidget {
  final Widget child;
  final Axis clipDirection;

  const ClippedView(
      {Key? key, required this.child, this.clipDirection = Axis.horizontal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: clipDirection,
      child: child,
    );
  }
}
