import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friendzone/data/models/post.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostRepository {
  final storageRef = FirebaseStorage.instance.ref();
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance.currentUser;
  Future<List<Post>> getAllPost() async {
    List<Post> listPost = [];
    QuerySnapshot querySnapshot = await firestore
        .collection("post")
        .where("visible", isEqualTo: true)
        .orderBy("createdAt", descending: true)
        .get();
    for (var doc in querySnapshot.docs) {
      Post post = Post.fromFirestore(doc);
      listPost.add(post);
    }
    return listPost;
  }

  Future<bool> upPost(File file, String content,
      {int like = 0,
      bool? visible,
      String? avartarAuthor,
      required String idUser}) async {
    try {
      //Upload to Firebase
      final upLoad =
          storageRef.child('images/${basename(file.path)}').putFile(file);
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
            final url = await event.ref.getDownloadURL();
            await upFireStore(
                urlImage: url,
                content: content,
                like: like,
                visible: visible ?? true,
                idUser: idUser,
                avartarAuthor: avartarAuthor);
            break;

          case TaskState.canceled:
            log("Upload was canceled");
            break;
          case TaskState.error:
            break;
        }
      });

      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> upFireStore(
      {required String urlImage,
      String? avartarAuthor,
      required String content,
      required int like,
      required String idUser,
      bool? visible}) async {
    try {
      final idPost = firestore.collection("post").doc().id;
      List<dynamic> postPath = [];
      await firestore.collection("post").doc(idPost).set({
        "idUser": auth!.uid,
        "author": auth?.displayName ??
            auth!.email!.replaceAll(RegExp('[^A-Za-z0-9]'), ''),
        "content": content,
        "avartarAuthor": avartarAuthor,
        "imageUrl": urlImage,
        "like": like.toString(),
        "createdAt": DateTime.now(),
        "visible": true
      });
      final path = firestore.collection("post").doc(idPost).path;
      postPath.add(path);
      await updateMeFirestore(
          idDoc: idUser, avartar: avartarAuthor, posts: postPath);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  updateMeFirestore(
      {required String idDoc,
      String? avartar,
      required List<dynamic> posts}) async {
    await firestore.collection("users").doc(idDoc).update(
        {'avartar': avartar ?? '', 'posts': FieldValue.arrayUnion(posts)});
  }
}
