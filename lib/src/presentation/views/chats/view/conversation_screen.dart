import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/presentation/state/chat/conversation/conversation_cubit.dart';
import 'package:friendzone/src/presentation/state/profile/myaccount/my_account_cubit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:timeago/timeago.dart' as timeago;

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
    await bloc.listenMessage(widget.userModel.idUser);
    jumNewMessage();
  }

  jumNewMessage() {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => controller.jumpTo(controller.position.maxScrollExtent));
  }

  _isMe(ChatMessage chatMessage) =>
      chatMessage.sender != widget.userModel.idUser;
  _crossAxisAlignment(item) =>
      _isMe(item) ? CrossAxisAlignment.end : CrossAxisAlignment.start;
  _backgroundColorItem(item) =>
      _isMe(item) ? colorBlue.shade500 : colorGrey.shade400;
  _colorText(item) => _isMe(item) ? colorWhite : colorBlack;

  @override
  Widget build(BuildContext context) {
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
                  builder: (_, message) {
                    if (message is MessageState) {
                      if (list.isEmpty || message.message.id != list.last.id) {
                        list.add(message.message);
                      }
                    }
                    return ListView.builder(
                        dragStartBehavior: DragStartBehavior.down,
                        controller: controller,
                        itemCount: list.length,
                        itemBuilder: (_, i) => _itemMessage(list[i]));
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
              height: 80,
              color: colorGrey.shade100,
              padding: const EdgeInsets.fromLTRB(16.0, 4.0, 0, 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'message',
                        hintStyle: const TextStyle(fontSize: 14),
                        contentPadding: const EdgeInsets.all(16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
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

  Widget _itemMessage(ChatMessage item) => Padding(
        padding: EdgeInsets.fromLTRB(
            !_isMe(item) ? 8.0 : 80, 8, _isMe(item) ? 8.0 : 80, 8),
        child: Column(
          crossAxisAlignment: _crossAxisAlignment(item),
          children: [
            Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: _backgroundColorItem(item),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft:
                          _isMe(item) ? const Radius.circular(16) : Radius.zero,
                      bottomRight: !_isMe(item)
                          ? const Radius.circular(16)
                          : Radius.zero,
                    )),
                child: Column(
                  crossAxisAlignment: _crossAxisAlignment(item),
                  children: [
                    Text(
                      item.message,
                      style: TextStyle(color: _colorText(item)),
                    ),
                    Text(
                      timeago.format(item.createdAt),
                      style: TextStyle(color: _colorText(item)),
                    ),
                  ],
                )),
          ],
        ),
      );
}
