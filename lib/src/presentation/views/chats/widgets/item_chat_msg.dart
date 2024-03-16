import 'package:flutter/material.dart';
import 'package:friendzone/src/domain/models/conversation.dart';
import 'package:friendzone/src/domain/models/user_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class ItemMsg extends StatelessWidget {
  final ChatMessage item;
  final UserModel user;
  const ItemMsg({super.key, required this.item, required this.user});

  _isMe(ChatMessage chatMessage) => chatMessage.sender != user.idUser;
  _crossAxisAlignment(item) =>
      _isMe(item) ? CrossAxisAlignment.end : CrossAxisAlignment.start;
  // _backgroundColorItem(BuildContext context,item) =>
  //     _isMe(item) ? colorBlue.shade500 : colorGrey.shade400;
  // _colorText(item) => _isMe(item) ? colorWhite : colorBlack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          !_isMe(item) ? 8.0 : 80, 0, _isMe(item) ? 8.0 : 80, 8),
      child: Column(
        crossAxisAlignment: _crossAxisAlignment(item),
        children: [
          Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  // color: _backgroundColorItem(item),
                  borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft:
                    _isMe(item) ? const Radius.circular(16) : Radius.zero,
                bottomRight:
                    !_isMe(item) ? const Radius.circular(16) : Radius.zero,
              )),
              child: Column(
                crossAxisAlignment: _crossAxisAlignment(item),
                children: [
                  Text(
                    item.message,
                    // style: TextStyle(color: _colorText(item)),
                  ),
                  Text(
                    timeago.format(item.createdAt),
                    // style: TextStyle(color: _colorText(item)),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
