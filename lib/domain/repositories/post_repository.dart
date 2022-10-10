import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friendzone/data/models/post.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostRepository {
  final storageRef = FirebaseStorage.instance.ref();
  final firestore = FirebaseFirestore.instance.collection("post");
  final auth = FirebaseAuth.instance.currentUser;
  Future<List<Post>> getAllPost() async {
    List<Post> listPost = [];
    QuerySnapshot querySnapshot = await firestore.get();
    for (var doc in querySnapshot.docs) {
      Post post = Post.fromMap({
        'idUser': doc["idUser"],
        "content": doc["content"],
        "imageUrl": doc["imageUrl"],
        "email": doc["email"],
        "like": doc["like"],
        "createdAt": doc["createdAt"].toDate()
      });
      listPost.add(post);
    }
    return listPost;
  }

  Future<bool> upPost(File file, String content, {int like = 0}) async {
    //Tạo một tham chiếui

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
            await upFireStore(url, content, like);
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

  Future<bool> upFireStore(String urlImage, String content, int like) async {
    try {
      firestore.doc(firestore.doc().id).set({
        "idUser": auth!.uid,
        "email": auth!.email,
        "content": content,
        "imageUrl": urlImage,
        "like": like.toString(),
        "createdAt": DateTime.now()
      });
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
