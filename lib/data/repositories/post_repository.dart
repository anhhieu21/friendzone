import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:friendzone/data.dart';
import 'package:friendzone/data/models/comment.dart';
import 'package:collection/collection.dart';
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
        .where("idUser", isNotEqualTo: auth!.uid)
        .orderBy("idUser")
        .orderBy("createdAt", descending: true)
        .get();
    for (var doc in querySnapshot.docs) {
      Post post = Post.fromFirestore(doc);
      listPost.add(post);
    }
    return listPost;
  }

  Future<bool> upPost(File file, String content,
      {int like = 0, bool? visible, required UserModel userModel}) async {
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
                urlImage: [url],
                content: content,
                like: like,
                visible: visible ?? true,
                userModel: userModel);
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
      {required List<String> urlImage,
      required String content,
      required int like,
      required UserModel userModel,
      bool? visible}) async {
    try {
      final idPost = firestore.collection("post").doc().id;
      List<dynamic> postPath = [];
      await firestore.collection("post").doc(idPost).set({
        "id": idPost,
        "idUser": userModel.idUser,
        "author": userModel.name,
        "content": content,
        "avartarAuthor": userModel.avartar,
        "imageUrl": urlImage,
        "like": like.toString(),
        "visible": visible,
        "createdAt": DateTime.now()
      });
      final path = firestore.collection("post").doc(idPost).path;
      postPath.add(path);
      firestore.collection("like").doc(idPost).set({"ids": []});

      await updateMeFirestore(
          idDoc: userModel.idUser, avartar: userModel.avartar, posts: postPath);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future likePost(Post post, UserModel user) async {
    final likeCount = int.parse(post.like) + 1;
    try {
      final docLike = firestore.collection("like").doc(post.id);
      final getDocLike = await docLike.get();
      if (!getDocLike.exists) {
        final like = Like(id: post.id, idsUser: [user.idUser]);
        await docLike.set(like.toMap());
        await _updateLike(post, likeCount);
        post.like = likeCount.toString();
      } else {
        final x = Like.fromFirestore(getDocLike)
            .idsUser
            .firstWhereOrNull((e) => e == user.idUser);
        if (x == null) {
          await docLike.update({
            "idsUser": FieldValue.arrayUnion([user.idUser]),
          });
          await _updateLike(post, likeCount);
          post.like = likeCount.toString();
        }
      }
      return post;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future _updateLike(Post post, int likeCount) async {
    await firestore
        .collection("post")
        .doc(post.id)
        .update({"like": '$likeCount'});
  }

  Future<Like?> getLikePost(Post post) async {
    try {
      final docLike = await firestore.collection("like").doc(post.id).get();
      final res = Like.fromFirestore(docLike);
      return res;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  updateMeFirestore(
      {required String idDoc,
      String? avartar,
      required List<dynamic> posts}) async {
    await firestore.collection("users").doc(idDoc).update(
        {'avartar': avartar ?? '', 'posts': FieldValue.arrayUnion(posts)});
  }

  Future<List<Comment>> getComments(String idPost) async {
    List<Comment> comments = [];
    // QuerySnapshot querySnapshot = await firestore
    //     .collection("comment")
    //     .where("id", isEqualTo: idPost)
    //     .orderBy("createdAt", descending: false)
    //     .get();
    QuerySnapshot querySnapshot = await firestore
        .collection("post")
        .doc(idPost)
        .collection('comment')
        .get();
    for (var e in querySnapshot.docs) {
      final comment = Comment.fromFirestore(e);
      comments.add(comment);
    }
    return comments;
  }

  Future<Comment> insertComments(String idPost, Comment comment) async {
    final autoID =
        firestore.collection("post").doc(idPost).collection('comment').doc().id;
    comment.id = autoID;
    await firestore
        .collection("post")
        .doc(idPost)
        .collection('comment')
        .doc(comment.id)
        .set(comment.toMap());
    return comment;
  }
}
