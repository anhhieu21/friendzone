import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friendzone/common/constants/list_img_fake.dart';
import 'package:friendzone/common/extentions/size_extention.dart';
import 'package:friendzone/presentation/views/chats/view/widgets/item_chat.dart';
import 'package:friendzone/presentation/views/widgets/custom_textfield.dart';
import 'package:ionicons/ionicons.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = SizeEx(context).screenSize;
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          return Scaffold(
              appBar: AppBar(
                title: Text(user?.displayName.toString() ?? ""),
                actions: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(Ionicons.videocam)),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Ionicons.add_outline))
                ],
                bottom: const PreferredSize(
                    preferredSize: Size.fromHeight(40),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: CustomTextField(
                        hint: 'tìm kiếm',
                        error: 'error',
                        padding: 6,
                      ),
                    )),
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
        });
  }
}
