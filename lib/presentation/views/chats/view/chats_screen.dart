import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/common/extentions/size_extention.dart';
import 'package:friendzone/presentation/shared.dart';
import 'package:friendzone/presentation/state/chat/chats_cubit.dart';
import 'package:friendzone/presentation/views/chats/widgets/item_chat.dart';
import 'package:ionicons/ionicons.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = SizeEx(context).screenSize;

    return Scaffold(
        appBar: AppBar(
          title: const CustomTextField(
            hint: 'tìm kiếm',
            error: 'error',
            padding: 6,
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Ionicons.videocam)),
            IconButton(onPressed: () {}, icon: const Icon(Ionicons.add_outline))
          ],
        ),
        body: BlocBuilder<ChatsCubit, ChatsState>(
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
