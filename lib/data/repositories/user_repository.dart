import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friendzone/common/constants/list_img_fake.dart';
import 'dart:developer';

import 'package:friendzone/data/models/post.dart';
import 'package:friendzone/data/models/user_model.dart';
import 'package:friendzone/data/repositories/auth_repository.dart';

class UserRepository {
  final firestore = FirebaseFirestore.instance;
  final userFromFireBase = AuthRepository.instance.user;
  Future<List<UserModel>> getAllUser() async {
    List<UserModel> listUser = [];
    QuerySnapshot querySnapshot = await firestore.collection("users").get();
    for (var doc in querySnapshot.docs) {
      UserModel user = UserModel.fromDocFireStore(doc);
      listUser.add(user);
    }
    return listUser;
  }

  Future<void> insertUserToFireStore(User user) async {
    try {
      await firestore.collection('users').doc(user.uid).set({
        "idUser": user.uid,
        "avartar": user.photoURL ?? urlAvatar,
        "email": user.email,
        "name": user.displayName ?? user.email,
        "phone": user.phoneNumber,
        "backgroun": '',
        "posts": [],
      });
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
    }
  }

  Future<UserModel> findMe() async {
    final user = FirebaseAuth.instance.currentUser!;
    final doc = await firestore.collection("users").doc(user.uid).get();
    final res = UserModel.fromDocFireStore(doc);
    return res;
  }

  Future<List<Post>> getMyPost() async {
    List<Post> list = [];
    QuerySnapshot querySnapshot = await firestore
        .collection("post")
        .where("idUser", isEqualTo: userFromFireBase!.uid)
        .orderBy("createdAt")
        .get();
    for (var doc in querySnapshot.docs) {
      final post = Post.fromFirestore(doc);
      list.add(post);
    }
    return list;
  }
}
