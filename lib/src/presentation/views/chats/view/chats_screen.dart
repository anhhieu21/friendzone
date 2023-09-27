import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/config/themes/color.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/presentation/views/chats/view/chats_option_screen.dart';
import 'package:friendzone/src/presentation/widgets/ontap_effect.dart';

import 'package:ionicons/ionicons.dart';

enum MenuChat {
  chat(label: 'Chat', icon: Ionicons.chatbubbles),
  privateChat(label: 'Private chat', icon: Ionicons.shield),
  archiveChat(label: 'Archived', icon: Ionicons.archive),
  waitingChat(label: 'Chat request', icon: Ionicons.chatbubble_ellipses);

  final String label;
  final IconData icon;

  const MenuChat({required this.label, required this.icon});
}

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final StreamController<MenuChat> _menuChatStream =
      StreamController<MenuChat>.broadcast();
  @override
  void initState() {
    BlocProvider.of<FriendzoneBloc>(context, listen: false)
        .add(MyFriendEvent());
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _onTapItemDrawer(MenuChat menuChat) {
    _menuChatStream.sink.add(menuChat);
    _closeEndDrawer();
  }

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  void _closeEndDrawer() {
    _scaffoldKey.currentState!.closeEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return StreamBuilder<MenuChat>(
        stream: _menuChatStream.stream,
        builder: (context, snapshot) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text(snapshot.data?.label ?? text.chat),
              actions: [
                IconButton(
                    onPressed: _openEndDrawer,
                    icon: const Icon(Ionicons.reorder_three))
              ],
            ),
            endDrawer: _drawer(theme, snapshot.data),
            body: ChatsOptionScreen(menuChat: snapshot.data ?? MenuChat.chat),
          );
        });
  }

  Widget _drawer(theme, value) => Drawer(
        child: Container(
          color: theme.scaffoldBackgroundColor,
          padding: const EdgeInsets.fromLTRB(9.0, kToolbarHeight, 8.0, 0),
          child: Column(
            children: MenuChat.values
                .map(
                  (e) => ItemMenuChat(
                    iconData: e.icon,
                    label: e.label,
                    callback: () => _onTapItemDrawer(e),
                    isSelect: e == (value ?? MenuChat.chat),
                  ),
                )
                .toList(),
          ),
        ),
      );
}

class ItemMenuChat extends StatelessWidget {
  final IconData iconData;
  final String label;
  final VoidCallback callback;
  final bool isSelect;
  const ItemMenuChat(
      {super.key,
      required this.iconData,
      required this.label,
      required this.callback,
      required this.isSelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          OnTapEffect(
            radius: 16.0,
            onTap: callback,
            child: Ink(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16.0)),
              child: Row(
                children: [
                  Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: colorGrey.shade100,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Icon(iconData)),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(label),
                  ))
                ],
              ),
            ),
          ),
          if (isSelect)
            Positioned(
              left: 0,
              child: Container(
                height: 30,
                width: 6,
                decoration: const BoxDecoration(
                    color: colorPrimary,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    )),
              ),
            ),
        ],
      ),
    );
  }
}
