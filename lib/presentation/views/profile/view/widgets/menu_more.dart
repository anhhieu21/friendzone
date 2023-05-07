import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/presentation/shared/bloc/auth/auth_bloc.dart';
import 'package:friendzone/presentation/shared/widgets/custom_overlayentry.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:ionicons/ionicons.dart';

enum More { settings, signout }

class MenuDrop extends StatefulWidget {
  const MenuDrop({super.key});

  @override
  State<MenuDrop> createState() => _MenuDropState();
}

class _MenuDropState extends State<MenuDrop> {
  _onChanged(Enum? value, context) {
    switch (value) {
      case More.settings:
        break;
      case More.signout:
        BlocProvider.of<AuthBloc>(context).add(SignOutRequested());
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final renderBox = context.findRenderObject() as RenderBox?;
        final offset = renderBox?.localToGlobal(Offset.zero);
        CustomOverlayEntry.instance.showOverlay();
      },
      style: IconButton.styleFrom(
        backgroundColor: colorGrey.shade300,
      ),
      icon: Icon(Ionicons.ellipsis_horizontal, color: colorBlue.shade500),
      //   ),
      // child: DropdownButtonHideUnderline(
      //     child: DropdownButton2(
      //   customButton: Icon(
      //     Ionicons.ellipsis_horizontal,
      //     color: colorBlue.shade500,
      //   ),
      //   items: const [
      //     DropdownMenuItem<Enum>(
      //         value: More.settings,
      //         child: ItemMenu(
      //           icon: Icon(Ionicons.settings),
      //           label: 'Cài đặt',
      //         )),
      //     DropdownMenuItem<Enum>(
      //         value: More.signout,
      //         child: ItemMenu(
      //           icon: Icon(Ionicons.log_out),
      //           label: 'Đăng xuất',
      //         )),
      //   ],
      //   onChanged: (value) => _onChanged(value, context),
      // itemHeight: 48,
      // itemPadding: const EdgeInsets.only(left: 16, right: 16),
      // dropdownWidth: 160,
      // dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
      // dropdownDecoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(12), color: colorWhite),
      // dropdownElevation: 8,
      // offset: const Offset(0, -20),
      // )),
    );
  }
}

class ItemMenu extends StatelessWidget {
  final Icon icon;
  final String label;
  const ItemMenu({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(
          width: 5,
        ),
        Expanded(child: Text(label)),
      ],
    );
  }
}
