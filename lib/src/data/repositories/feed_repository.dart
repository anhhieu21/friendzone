import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class FeedRepository {
  final storageRef = FirebaseStorage.instance.ref();
  final firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  Future<List<Feed>> getStories() async {
    final stories = <Feed>[];
    final res = await firestore
        .collection(kFeed)
        .orderBy("createdAt", descending: true)
        .get();
    for (var element in res.docs) {
      final story = Feed.fromMap(element);
      stories.add(story);
    }
    return stories;
  }

  Future<Feed?> createFeed(XFile image, UserModel userModel) async {
    Feed? feed;
    final file = File(image.path);

    final imgRef = storageRef.child('images/${basename(file.path)}');
    try {
      final upLoadTask = await imgRef.putFile(file);
      switch (upLoadTask.state) {
        case TaskState.paused:
          if (kDebugMode) {
            print("Upload is paused.");
          }
          break;
        case TaskState.running:
          final progress =
              100.0 * (upLoadTask.bytesTransferred / upLoadTask.totalBytes);
          if (kDebugMode) {
            print(("Upload is $progress% complete."));
          }
          break;
        case TaskState.success:
          final url = await upLoadTask.ref.getDownloadURL();
          feed = await _insertToFirestore(url, userModel);
          return feed;

        case TaskState.canceled:
          if (kDebugMode) {
            print("Upload was canceled");
          }
          break;
        case TaskState.error:
          break;
      }
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
    }

    return feed;
  }

  Future<Feed?> _insertToFirestore(String image, UserModel userModel) async {
    try {
      final idFeed = firestore.collection(kFeed).doc().id;
      final feed = Feed(
          id: idFeed,
          idUser: userModel.idUser,
          imagesUrl: [image],
          author: userModel.name,
          createdAt: DateTime.now().toString(),
          avartarAuthor: userModel.avartar);
      await firestore.collection(kFeed).doc(idFeed).set(feed.toMap());
      return feed;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }
}
