import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:friendzone/data/models/story.dart';

class StoriesRepository {
  final storageRef = FirebaseStorage.instance.ref();
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance.currentUser;

  Future<List<Story>> getStories() async {
    final stories = <Story>[];
    final res = await firestore
        .collection("stories")
        .orderBy("createdAt", descending: true)
        .get();
    for (var element in res.docs) {
      final story = Story.fromMap(element);
      stories.add(story);
    }
    return stories;
  }

  Future<bool> createStory(Story story) async {
    try {
      await firestore.collection("stories").doc().set(story.toMap());
      return true;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }
}
