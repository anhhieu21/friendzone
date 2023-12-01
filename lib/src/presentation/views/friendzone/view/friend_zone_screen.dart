import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:friendzone/src/domain/models/user_model.dart';
import 'package:ionicons/ionicons.dart';

class FriendZoneScreen extends StatefulWidget {
  const FriendZoneScreen({super.key});

  @override
  State<FriendZoneScreen> createState() => _FriendZoneScreenState();
}

class _FriendZoneScreenState extends State<FriendZoneScreen> {
  final TextEditingController controllerSearch = TextEditingController();
  List<UserModel> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controllerSearch,
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
                onPressed: () async {
                  users = [];
                  final res = await FirebaseFirestore.instance
                      .collection('users')
                      .where("name", isNotEqualTo: controllerSearch.text)
                      .orderBy("name")
                      .startAt([
                    controllerSearch.text,
                  ]).endAt([
                    '${controllerSearch.text}\uf8ff',
                  ]).get();
                  for (var e in res.docs) {
                    users.add(UserModel.fromMap(e.data()));
                  }
                  setState(() {});
                },
                padding: EdgeInsets.zero,
                icon: const Icon(Ionicons.search))
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Search history',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          // users.map(e) =>
          ...users.map((e) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: CachedNetworkImageProvider(e.avartar),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(child: Text(e.name)),
                    IconButton(
                        onPressed: () {
                          users.remove(e);
                          setState(() {});
                        },
                        icon: const Icon(Ionicons.close))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
