import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/domain/repositories/post_repository.dart';

import 'post_cubit_state.dart';

class PostCubit extends Cubit<PostCubitState> {
  PostRepository postRepository;
  List<Comment> _comments = [];
  PostCubit(
    this.postRepository,
  ) : super(const PostCubitState());

  Future<void> init(String id) async {
    _comments = await postRepository.getComments(id);
    final save = await postRepository.isSaved(id);

    emit(state.copyWith(isSaved: save, comments: _comments));
  }

  Future<void> likePost(Post post, UserModel userModel) async {
    try {
      final res = await postRepository.likePost(post, userModel);
      if (res == null) return;
      res.isLiked = await _isLiked(res.id);
      emit(state.copyWith(post: res));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
    }
  }

  Future<void> commentPost(String idPost) async {
    try {
      final res = await postRepository.getComments(idPost);
      _comments = res;
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
    }
  }

  Future<void> insertCommentPost(String idPost, Comment comment) async {
    try {
      final res = await postRepository.insertComments(idPost, comment);
      _comments.add(res);
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
    }
  }

  Future<bool> _isLiked(String id) async {
    final res = await postRepository.getLikePost(id);
    final idUser = FirebaseAuth.instance.currentUser!.uid;
    if (res != null) {
      final like = res.idsUser.firstWhereOrNull((e) => e == idUser);
      return like != null;
    }
    return false;
  }
}
