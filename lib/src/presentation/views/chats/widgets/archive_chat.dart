import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/utils.dart';

import 'item_list_conversation.dart';

class ArchiveChat extends StatelessWidget {
  const ArchiveChat({super.key});

  @override
  Widget build(BuildContext context) {
    final size = SizeEx(context).screenSize;
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (_, state) => Column(children: [
        if (state is ListConversationState)
          Expanded(
            child: ListView.builder(
                itemCount: state.listConversation.length,
                itemBuilder: (context, index) {
                  return ItemListConversation(
                      size: size, item: state.listConversation[index]);
                }),
          )
      ]),
    );
  }
}
