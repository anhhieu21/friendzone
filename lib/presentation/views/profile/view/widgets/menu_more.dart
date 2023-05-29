import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/presentation/routes/path.dart';
import 'package:friendzone/presentation/shared/bloc/auth/auth_bloc.dart';
import 'package:friendzone/presentation/shared/widgets/custom_overlayentry.dart';
import 'package:friendzone/presentation/shared/widgets/ontap_effect.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

enum More { settings, signout }

class MenuDrop extends StatefulWidget {
  const MenuDrop({super.key});

  @override
  State<MenuDrop> createState() => _MenuDropState();
}

class _MenuDropState extends State<MenuDrop> {
  @override
  void initState() {
    super.initState();
  }

  _handlerItem(Enum? value) {
    CustomOverlayEntry.instance.hideOverlay();
    switch (value) {
      case More.settings:
        break;
      case More.signout:
        BlocProvider.of<AuthBloc>(context).add(SignOutRequested());
        break;
      default:
    }
  }

  _openPopup() {
    final renderBox = context.findRenderObject() as RenderBox?;
    final offset = renderBox?.localToGlobal(Offset.zero);
    CustomOverlayEntry.instance.showOverlay(
      context,
      child: Positioned(
        top: offset!.dy + 50,
        right: 16,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), color: colorWhite),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: More.values
                .map(
                  (e) => OnTapEffect(
                    onTap: () => _handlerItem(e),
                    radius: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(e.name),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          GoRouter.of(context).go(RoutePath.splash);
        }
      },
      child: IconButton(
        onPressed: _openPopup,
        style: IconButton.styleFrom(
          backgroundColor: colorGrey.shade300,
        ),
        icon: Icon(Ionicons.ellipsis_horizontal, color: colorBlue.shade500),
      ),
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
