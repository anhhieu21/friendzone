import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class PostRepository {
  final storageRef = FirebaseStorage.instance.ref();
  final firestore = FirebaseFirestore.instance.collection("post");
  final auth = FirebaseAuth.instance.currentUser;
  Future getAllPost() async {
    QuerySnapshot querySnapshot = await firestore.get();
    final posts = querySnapshot.docs.map((e) => e.data()).toList();
  }

  Future<bool?> upPost(String content, {int like = 0}) async {
    //Tạo một tham chiếu

    final picker = ImagePicker();
    XFile? image;
    bool? isSuccess;
    try {
      image = await picker.pickImage(source: ImageSource.gallery);
      var file = File(image?.path ?? '');
      if (image != null) {
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
              isSuccess = true;
              final url = await event.ref.getDownloadURL();

              upFireStore(url, content, like);
              break;
            case TaskState.canceled:
              log("Upload was canceled");
              break;
            case TaskState.error:
              isSuccess = false;
              break;
          }
        });
      } else {
        log('No Image Path Received');
      }
      return isSuccess;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future upFireStore(String urlImage, String content, int like) async {
    try {
      firestore.doc(firestore.doc().id).set({
        "idUser": auth!.uid,
        "email": auth!.email,
        "content": content,
        "imageUrl": urlImage,
        "like": like.toString(),
        "createdAt": DateTime.now()
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
