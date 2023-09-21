import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:friendzone/src/domain.dart';

abstract class UserRepository {
  Future<List<UserModel>> getAllUser();

  Future<void> insertUserToFireStore(User user);

  Future<UserModel?> findUser(String idUser);

  Future<List<Post>> getMyPost(String idUser);

  Future<bool> updateProfile(
      {String? displayName, String? phone, File? file, String? bio});

  Future<bool> followUser(Following following, Follower follower,
      int countFollower, int countFollowing);

  Future<bool> checkFollower(String idUser);

  Future<List<Follower>> getFollower(String docId);

  Future<List<Follower>> getFollowing(String docId);

  Future<bool> savePost(Post post);

  Future unSavePost(Post post);

  Future<List<Post>> getPostSave();
}
