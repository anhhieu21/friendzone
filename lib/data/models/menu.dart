import 'package:flutter/material.dart';
class Menu {
  String title;
  IconData? iconData;
  Menu({required this.title, this.iconData});

  factory Menu.fromMap(Map<String, dynamic> map) {
    return Menu(title: map['title'], iconData: map['iconData']);
  }
}
