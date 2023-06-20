import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  User? user;
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
        "name": user.displayName ?? Formatter.emailtoDisplayName(user.email!),
        "phone": user.phoneNumber,
        "background": '',
        "posts": [],
        "bio": '',
      });
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
    }
  }

  Future<UserModel> findMe(String idUser) async {
    final doc = await firestore.collection("users").doc(idUser).get();
    final res = UserModel.fromDocFireStore(doc);
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
                await _firebaseAuth.currentUser!.updatePhotoURL(urlImage);
              }
              break;

            case TaskState.canceled:
              log("Upload was canceled");
              break;
            case TaskState.error:
              break;
          }
        });
      }
      if (displayName!.isNotEmpty) {
        await _firebaseAuth.currentUser!.updateDisplayName(displayName);
        await firestore.collection("users").doc(user!.uid).update({
          'name': displayName,
          'phone': phone,
          'bio': bio,
        });
      }
      // if (phone!.isNotEmpty) {
      //   await _firebaseAuth.currentUser!.updatePhoneNumber(ph);
      // }

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
