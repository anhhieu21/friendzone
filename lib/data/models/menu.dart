import 'package:flutter/material.dart';

class Menu {
  String title;
  IconData? iconData;
  Enum? func;
  Menu({required this.title, this.iconData, this.func});

  factory Menu.fromMap(Map<String, dynamic> map) {
    return Menu(title: map['title'], iconData: map['iconData']);
  }
}

enum MenuReels { like, comment, create }
