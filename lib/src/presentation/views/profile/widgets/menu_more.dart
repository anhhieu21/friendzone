import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/core/config/routes/path.dart';
import 'package:friendzone/src/presentation/shared.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/presentation/widgets/animation_popup_menu.dart';

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

  _handlerItem(String value) {
    CustomOverlayEntry.instance.hideOverlay();
    if (value == text.settings) {
      context.pushNamed(RoutePath.routeName(RoutePath.settings));
    }
    if (value == text.signout) {
      BlocProvider.of<AuthBloc>(context).add(SignOutRequested());
    }
  }

  _openPopup() {
    final renderBox = context.findRenderObject() as RenderBox?;
    final offset = renderBox?.localToGlobal(Offset.zero);
    final menu = [text.settings, text.signout];
    CustomOverlayEntry.instance.showOverlay(
      context,
      child: Positioned(
        top: offset!.dy + 50,
        right: 16,
        child: AnimationPopupMenu(
          child: Card(
            elevation: 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: menu
                  .map(
                    (e) => OnTapEffect(
                      onTap: () => _handlerItem(e),
                      radius: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(e),
                      ),
                    ),
                  )
                  .toList(),
            ),
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
      child: IconButton.filledTonal(
        onPressed: _openPopup,
        icon: const Icon(
          Ionicons.ellipsis_horizontal,
        ),
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
