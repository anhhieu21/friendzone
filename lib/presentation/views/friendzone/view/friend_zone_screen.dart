import 'package:flutter/material.dart';
import 'package:friendzone/presentation/views/widgets/custom_textfield.dart';
import 'package:ionicons/ionicons.dart';

class FriendZoneScreen extends StatelessWidget {
  FriendZoneScreen({super.key});
  final TextEditingController controllerSearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          
          children: [
            Expanded(
              child: CustomTextField(
                controller: controllerSearch,
                hint: 'tìm kiếm',
                error: 'error',
                padding: 6,
              ),
            ),
            IconButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                icon: const Icon(Ionicons.search))
          ],
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
