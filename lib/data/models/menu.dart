import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

final menuBottomNavBar = [
  {'title': 'Home','iconData':Ionicons.home},
  {'title': 'Chat','iconData':Ionicons.chatbubble},
  {'title': 'Friend','iconData':Ionicons.people},
  {'title': 'Profile','iconData':Ionicons.home},
];

class Menu {
  String title;
  IconData? iconData;
  Menu({required this.title, this.iconData});

  factory Menu.fromMap(Map<String, dynamic> map) {
    return Menu(title: map['title'], iconData: map['iconData']);
  }
}
