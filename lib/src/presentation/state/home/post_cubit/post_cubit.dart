import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/domain/repositories/post_repository.dart';

import 'package:collection/collection.dart';
import 'post_cubit_state.dart';

class PostCubit extends Cubit<PostCubitState> {
  PostRepository postRepository;
  List<Comment> _comments = [];
  PostCubit(
    this.postRepository,
  ) : super(const PostCubitState());

  Future<void> init(String id) async {
    String? liked;
    final save = await postRepository.isSaved(id);

    final res = await postRepository.getLikePost(id);
    final idUser = FirebaseAuth.instance.currentUser!.uid;
    if (res != null) {
      liked = res.idsUser.firstWhereOrNull((e) => e == idUser);
    }

    emit(state.copyWith(isSaved: save, isLiked: liked != null));
  }

  Future<void> likePost(Post post, UserModel userModel) async {
    try {
      final res = await postRepository.likePost(post, userModel);
      emit(state.copyWith(post: res));
      init(post.id);
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
    }
  }

  Future<void> commentPost(String idPost) async {
    try {
      final res = await postRepository.getComments(idPost);
      _comments = res;
      emit(state.copyWith(comments: res));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
    }
  }

  Future<void> insertCommentPost(String idPost, Comment comment) async {
    try {
      final res = await postRepository.insertComments(idPost, comment);
      _comments.add(res);
      emit(state.copyWith(comments: _comments));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
    }
  }
}
