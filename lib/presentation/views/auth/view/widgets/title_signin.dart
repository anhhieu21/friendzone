import 'package:flutter/material.dart';

class TitleSignIn extends StatelessWidget {
  const TitleSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      title: Text(
        'Hello Hiếu,',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        'Cùng nhau khám phá FriendZone nhé !',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
