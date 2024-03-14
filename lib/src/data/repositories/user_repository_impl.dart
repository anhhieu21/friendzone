import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:friendzone/src/core/utils/compress_file.dart';
import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/domain/repositories/user_repository.dart';
import 'package:friendzone/src/utils.dart';
import 'dart:developer';

import 'package:path/path.dart';

class UserRepositoryImpl implements UserRepository {
  final firestore = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;
  final storageRef = FirebaseStorage.instance.ref();
  @override
  Future<List<UserModel>> getAllUser() async {
    List<UserModel> listUser = [];
    QuerySnapshot querySnapshot = await firestore.collection("users").get();
    for (var doc in querySnapshot.docs) {
      UserModel user = UserModel.fromMap(doc.data() as Map);
      listUser.add(user);
    }
    return listUser;
  }

  @override
  Future<void> insertUserToFireStore(User user) async {
    try {
      final doc = firestore.collection('users').doc(user.uid);

      final getDoc = await doc.get();
      if (getDoc.exists) return;

      await doc.set({
        "idUser": user.uid,
        "avartar": user.photoURL ?? urlAvatar,
        "email": user.email,
        "name": user.displayName ?? Formatter.emailtoDisplayName(user.email!),
        "phone": user.phoneNumber,
        "background": '',
        "posts": [],
        "bio": '',
        "follower": 0,
        "following": 0,
      });
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
    }
  }

  @override
  Future<UserModel?> findUser(String idUser) async {
    try {
      final doc = await firestore.collection("users").doc(idUser).get();
      final data = doc.data();
      if (data == null) return null;
      final res = UserModel.fromMap(data);
      return res;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return null;
    }
  }

  @override
  Future<List<Post>> getMyPost(String idUser) async {
    List<Post> list = [];
    QuerySnapshot querySnapshot = await firestore
        .collection("post")
        .where("idUser", isEqualTo: idUser)
        .orderBy("createdAt")
        .get();
    for (var doc in querySnapshot.docs) {
      final post = Post.fromFirestore(doc);
      list.add(post);
    }
    return list;
  }

  @override
  Future<bool> updateProfile(
      {required UserModel user,
      File? file,
      bool isUpdateBackground = false}) async {
    try {
      String? urlImage;
      if (file != null) {
       //Upload to Firebase
      final fileCompress = await CompressFile.compressAndGetFile(file, file.path);
      final upLoad = await storageRef
          .child('images/${basename(fileCompress.path)}')
          .putFile(fileCompress);
        switch (upLoad.state) {
          case TaskState.paused:
            log("Upload is paused.");
            return false;
          case TaskState.running:
            final progress =
                100.0 * (upLoad.bytesTransferred / upLoad.totalBytes);
            log("Upload is $progress% complete.");
            return false;
          case TaskState.success:
            urlImage = await upLoad.ref.getDownloadURL();
            if (isUpdateBackground) {
              user.background = urlImage;
            } else {
              user.avartar = urlImage;
              await _firebaseAuth.currentUser!.updatePhotoURL(urlImage);
              await _firebaseAuth.currentUser!.updateDisplayName(user.name);
            }
            await firestore
                .collection("users")
                .doc(_firebaseAuth.currentUser!.uid)
                .update(user.toMap());
            return true;

          case TaskState.canceled:
            log("Upload was canceled");
            return false;
          case TaskState.error:
            return false;
        }
      } else {
        await _firebaseAuth.currentUser!.updateDisplayName(user.name);
        await firestore
            .collection("users")
            .doc(_firebaseAuth.currentUser!.uid)
            .update(user.toMap());
      }

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<bool> followUser(Following following, Follower follower,
      int countFollower, int countFollowing) async {
    final docMe = firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('following')
        .doc(following.idUser);
    // check
    final existed = await docMe.get();
    if (existed.exists) return false;

    //the user being followed
    final docUser = firestore
        .collection('users')
        .doc(following.idUser)
        .collection('follower')
        .doc(follower.idUser);
    //insert follower for user
    docUser.set(follower.toMap());
    //
    await docMe.set(following.toMap());

    // update qty following and follower
    await firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .update({kFollowing: countFollowing});
    await firestore
        .collection('users')
        .doc(following.idUser)
        .update({kFollower: countFollower});

    return true;
  }

  @override
  Future<bool> checkFollower(String idUser) async {
    final exists = await firestore
        .collection(kUser)
        .doc(idUser)
        .collection(kFollower)
        .doc(_firebaseAuth.currentUser!.uid)
        .get();
    return exists.exists;
  }

  @override
  Future<List<Follower>> getFollower(String docId) async {
    final list = <Follower>[];
    final res = await firestore
        .collection(kUser)
        .doc(docId)
        .collection(kFollower)
        .get();
    for (var element in res.docs) {
      final x = Follower.fromMap(element.data());
      list.add(x);
    }
    return list;
  }

  @override
  Future<List<Follower>> getFollowing(String docId) async {
    final list = <Follower>[];
    final res = await firestore
        .collection(kUser)
        .doc(docId)
        .collection(kFollowing)
        .get();
    for (var element in res.docs) {
      final x = Follower.fromMap(element.data());
      list.add(x);
    }
    return list;
  }

  @override
  Future<bool> savePost(Post post) async {
    final doc = firestore
        .collection(kUser)
        .doc(_firebaseAuth.currentUser!.uid)
        .collection(kPostSave)
        .doc(post.id);
    final getDoc = await doc.get();
    if (getDoc.exists) {
      unSavePost(post);
      return false;
    }
    await doc.set(post.toMap());
    return true;
  }

  @override
  Future unSavePost(Post post) async {
    await firestore
        .collection(kUser)
        .doc(_firebaseAuth.currentUser!.uid)
        .collection(kPostSave)
        .doc(post.id)
        .delete();
  }

  @override
  Future<List<Post>> getPostSave() async {
    List<Post> list = [];
    final querySnapshot = await firestore
        .collection(kUser)
        .doc(_firebaseAuth.currentUser!.uid)
        .collection(kPostSave)
        .get();
    for (var doc in querySnapshot.docs) {
      final res = Post.fromFirestore(doc);
      list.add(res);
    }
    return list;
  }
  
}
