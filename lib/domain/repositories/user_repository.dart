import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friendzone/data/models/post.dart';
import 'package:friendzone/data/models/user_model.dart';

class UserRepository {
  final firestore = FirebaseFirestore.instance;
  Future<List<Users>> getAllUser() async {
    List<Users> listUser = [];
    QuerySnapshot querySnapshot = await firestore.collection("users").get();
    for (var doc in querySnapshot.docs) {
      Users user = Users.fromMap(doc);
      listUser.add(user);
    }
    return listUser;
  }

  Future<Users> findMe() async {
    final querySnapshot =
        await firestore.doc(FirebaseAuth.instance.currentUser!.uid).get();
    Users user = Users.fromMap(querySnapshot);
    return user;
  }
  Future<void> insertUserToFireStore(User user) async {
    try {
      await firestore.doc(user.uid).set({
        "idUser": user.uid,
        "avartar": user.photoURL,
        "email": user.email,
        "name": user.displayName,
        "followed": false,
      });
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
    }
  }

  Future<Users> getUser() async {
    final doc = await firestore.collection("users").doc("idUser").get();
    Users user = Users.fromMap(doc);
    return user;
  }

  Future<List<Post>> getMyPost(String id) async {
    List<Post> list = [];
    QuerySnapshot querySnapshot = await firestore
        .collection("post")
        .where("idUser", isEqualTo: id)
        .orderBy("createdAt")
        .get();
    for (var doc in querySnapshot.docs) {
      final post = Post.fromFirestore(doc);
      list.add(post);
    }
    return list;
  }
}
