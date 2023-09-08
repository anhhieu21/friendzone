import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/presentation/view.dart';
import 'package:friendzone/src/utils.dart';

import 'package:ionicons/ionicons.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = SizeEx(context).screenSize;

    return Scaffold(
        appBar: AppBar(
          title: TextField(
            decoration: InputDecoration(
              hintText: 'Searching',
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Ionicons.videocam)),
            IconButton(onPressed: () {}, icon: const Icon(Ionicons.add_outline))
          ],
        ),
        body: BlocBuilder<ChatCubit, ChatState>(
          builder: (_, state) {
            if (state is ListConversationState) {
              return ListView.builder(
                  itemCount: state.listConversation.length,
                  itemBuilder: (context, index) {
                    return ItemChat(
                        size: size, item: state.listConversation[index]);
                  });
            }
            return const SizedBox();
          },
        ));
  }
}