import 'package:flutter/material.dart';
import 'package:friendzone/presentation/routes/path.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:go_router/go_router.dart';
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
          Text('Good morning Hieu'),
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {
              
              context.go('/${RoutePath.writepost}');
            },
            icon: Icon(
              Ionicons.create_outline,
              color: colorGrey.shade700,
            )),
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
  }
}
