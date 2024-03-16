import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/presentation/state/chat/conversation/conversation_cubit.dart';
import 'package:friendzone/src/presentation/state/profile/myaccount/my_account_cubit.dart';
import 'package:ionicons/ionicons.dart';

import '../widgets/item_chat_msg.dart';

class ConversationScreen extends StatefulWidget {
  final UserModel userModel;
  const ConversationScreen({super.key, required this.userModel});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final TextEditingController textEditingController = TextEditingController();
  ScrollController controller = ScrollController();
  @override
  void initState() {
    _loadMessages();

    super.initState();
  }

  _loadMessages() async {
    final bloc = BlocProvider.of<ConversationCubit>(context, listen: false);
    await bloc.listMessage(widget.userModel.idUser);
    jumNewMessage();
  }

  jumNewMessage() {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => controller.jumpTo(controller.position.maxScrollExtent));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userModel.name),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Ionicons.ellipsis_vertical))
        ],
      ),
      body: Stack(
        children: [
          BlocBuilder<ConversationCubit, ConversationState>(
            buildWhen: (previous, current) {
              if (current is ListMessageState) {
                return true;
              }
              return false;
            },
            builder: (context, state) {
              if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ListMessageState) {
                var list = state.messages;
                return BlocBuilder<ConversationCubit, ConversationState>(
                  builder: (_, messageState) {
                    if (messageState is MessageState) {
                      if (messageState.message.idConversation ==
                                  list.last.idConversation &&
                              list.isEmpty ||
                          messageState.message.id != list.last.id) {
                        list.add(messageState.message);
                      }
                    }
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: kBottomNavigationBarHeight + 20),
                      child: ListView.builder(
                          dragStartBehavior: DragStartBehavior.down,
                          controller: controller,
                          itemCount: list.length,
                          itemBuilder: (_, i) => ItemMsg(
                                item: list[i],
                                user: widget.userModel,
                              )),
                    );
                  },
                );
              }
              return const SizedBox();
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: kBottomNavigationBarHeight + 20,
              padding: const EdgeInsets.fromLTRB(0, 4.0, 0, 16.0),
              child: Row(
                children: [
                  IconButton(
                      style: IconButton.styleFrom(
                          backgroundColor: theme.cardColor),
                      onPressed: () async {
                        textEditingController.clear();
                        jumNewMessage();
                        _showAlbum();
                      },
                      icon: const Icon(Icons.photo_rounded)),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextFormField(
                        controller: textEditingController,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'message',
                          hintStyle: const TextStyle(fontSize: 14),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  BlocSelector<MyAccountCubit, MyAccountState, UserModel?>(
                    selector: (state) {
                      if (state is MyDataState) {
                        return state.user;
                      }
                      return null;
                    },
                    builder: (context, user) {
                      return IconButton(
                          onPressed: () async {
                            final value = textEditingController.text;
                            textEditingController.clear();
                            await BlocProvider.of<ConversationCubit>(context)
                                .sendMessage(widget.userModel, value, user!);
                            jumNewMessage();
                          },
                          icon: const Icon(Icons.send));
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showAlbum() {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        useSafeArea: true,
        builder: (_) => DraggableScrollableSheet(
              expand: true,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container();
              },
            ));
  }
}
