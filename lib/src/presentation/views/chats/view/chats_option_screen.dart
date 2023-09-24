import 'package:flutter/material.dart';
import 'package:friendzone/src/presentation/views/chats/view/chats_screen.dart';
import 'package:friendzone/src/presentation/views/chats/widgets/archive_chat.dart';
import 'package:friendzone/src/presentation/views/chats/widgets/main_chat.dart';
import 'package:friendzone/src/presentation/views/chats/widgets/private_chat.dart';
import 'package:friendzone/src/presentation/views/chats/widgets/waiting_chat.dart';

class ChatsOptionScreen extends StatelessWidget {
  final MenuChat menuChat;
  const ChatsOptionScreen({super.key, required this.menuChat});
  Widget _body() {
    switch (menuChat) {
      case MenuChat.chat:
        return const MainChat();
      case MenuChat.privateChat:
        return const PrivateChat();
      case MenuChat.archiveChat:
        return const ArchiveChat();
      case MenuChat.waitingChat:
        return const WaitingChat();
      default:
        return const MainChat();
    }
  }

  @override
  Widget build(BuildContext context) => _body();
}
