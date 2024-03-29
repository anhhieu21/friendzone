import 'dart:io';

import 'package:friendzone/src/domain.dart';

abstract class PostRepository {
  Future<List<Post>> getAllPost();

  Future<List<Post>> getAllPostNext();

  Future<bool> upPost(File file, String content,
      {int like = 0, bool? visible, required UserModel userModel});

  Future<bool> upFireStore(
      {required List<String> urlImage,
      required String content,
      required int like,
      required UserModel userModel,
      bool? visible});

  Future<Post?> likePost(Post post, UserModel user);

  Future<Like?> getLikePost(String id);

  Future<List<Comment>> getComments(String idPost);

  Future<Comment> insertComments(String idPost, Comment comment);

  Future<bool> isSaved(String id);
}
