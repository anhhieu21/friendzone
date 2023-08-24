import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:friendzone/common/constants/constants.dart';
import 'package:friendzone/common/constants/list_img_fake.dart';
import 'dart:developer';

import 'package:friendzone/data.dart';
import 'package:friendzone/presentation/utils/formatter.dart';
import 'package:path/path.dart';

class UserRepository {
  final firestore = FirebaseFirestore.instance;
  final userFromFireBase = AuthRepository.instance.user;
  final _firebaseAuth = FirebaseAuth.instance;
  final storageRef = FirebaseStorage.instance.ref();
  late UserModel _userModel;
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
      final doc = firestore.collection('users').doc(user.uid);

      final getDoc = await doc.get();
      if (!getDoc.exists) return;

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

  Future<UserModel> findMe(String idUser) async {
    final doc = await firestore.collection("users").doc(idUser).get();
    final res = UserModel.fromDocFireStore(doc);
    _userModel = res;
    return res;
  }

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

  Future<bool> updateProfile(
      {String? displayName, String? phone, File? file, String? bio}) async {
    try {
      final user = UserModel(
          idUser: _userModel.idUser,
          avartar: _userModel.avartar,
          email: _userModel.email,
          name: displayName!.isEmpty ? _userModel.name : displayName,
          background: _userModel.background,
          follower: _userModel.follower,
          following: _userModel.following,
          bio: bio ?? _userModel.bio,
          phone: phone!.isEmpty ? _userModel.phone : phone);
      String? urlImage;
      if (file != null) {
        final upLoad =
            storageRef.child('avatar/${basename(file.path)}').putFile(file);
        upLoad.snapshotEvents.listen((event) async {
          switch (event.state) {
            case TaskState.paused:
              log("Upload is paused.");
              break;
            case TaskState.running:
              final progress =
                  100.0 * (event.bytesTransferred / event.totalBytes);
              log("Upload is $progress% complete.");
              break;
            case TaskState.success:
              urlImage = await event.ref.getDownloadURL();
              if (urlImage != null) {
                user.avartar = urlImage!;
                await _firebaseAuth.currentUser!.updatePhotoURL(urlImage);
                await _firebaseAuth.currentUser!.updateDisplayName(displayName);
                await firestore
                    .collection("users")
                    .doc(_firebaseAuth.currentUser!.uid)
                    .update(user.toMap());
              }
              break;

            case TaskState.canceled:
              log("Upload was canceled");
              break;
            case TaskState.error:
              break;
          }
        });
      } else {
        await _firebaseAuth.currentUser!.updateDisplayName(displayName);
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

  Future<bool> checkFollower(String idUser) async {
    final exists = await firestore
        .collection(kUser)
        .doc(idUser)
        .collection(kFollower)
        .doc(_firebaseAuth.currentUser!.uid)
        .get();
    return exists.exists;
  }

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

  Future unSavePost(Post post) async {
    await firestore
        .collection(kUser)
        .doc(_firebaseAuth.currentUser!.uid)
        .collection(kPostSave)
        .doc(post.id)
        .delete();
  }

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
