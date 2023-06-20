import 'package:flutter/material.dart';
import 'package:friendzone/common/constants/list_img_fake.dart';
import 'package:friendzone/common/extentions/size_extention.dart';
import 'package:friendzone/presentation/shared.dart';
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: listPost.length,
                  itemBuilder: (context, index) {
                    return ItemChat(size: size, item: listPost[index]);
                  }),
            ),
          ],
        ));
  }
}
