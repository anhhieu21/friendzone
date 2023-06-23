import 'package:flutter/material.dart';
import 'package:friendzone/data.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:ionicons/ionicons.dart';

class ConversationScreen extends StatelessWidget {
  final UserModel userModel;
  ConversationScreen({super.key, required this.userModel});
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userModel.name),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Ionicons.ellipsis_vertical))
        ],
      ),
      body: const Column(
        children: [],
      ),
      bottomNavigationBar: Container(
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
            IconButton(onPressed: () {}, icon: const Icon(Icons.send))
          ],
        ),
      ),
    );
  }
}
