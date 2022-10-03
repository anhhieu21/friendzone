import 'package:flutter/material.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:ionicons/ionicons.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: const [
          CircleAvatar(
            radius: 20,
            backgroundColor: colorPinkButton,
          ),
          SizedBox(
            width: 6,
          ),
          Text('Hello Hieu'),
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Ionicons.person_add,
              color: colorGrey.shade700,
            )),
        IconButton(
            onPressed: () {},
            icon: Stack(
              children: [
                Icon(
                  Ionicons.notifications,
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
