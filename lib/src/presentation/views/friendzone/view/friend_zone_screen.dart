import 'package:flutter/material.dart';
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
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Searching',
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                icon: const Icon(Ionicons.search))
          ],
        ),
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
