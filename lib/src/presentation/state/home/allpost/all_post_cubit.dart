import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/domain/repositories/post_repository.dart';

part 'all_post_state.dart';

class AllPostCubit extends Cubit<AllPostState> {
  final PostRepository _repoPost;

  AllPostCubit(this._repoPost) : super(AllPostInitial());
  List<Post> _allPost = [];
  getAllPost() async {
    _allPost = [];
    _allPost = await _repoPost.getAllPost();
    for (var element in _allPost) {
      element.isLiked = await _isLiked(element.id);
    }
    emit(AllPostShow(_allPost));
  }

  Future getAllPostNext() async {
    final allPost = await _repoPost.getAllPostNext();
    _allPost.addAll(allPost);
    await Future.delayed(const Duration(seconds: 2));
    emit(AllPostShow(_allPost));
  }

  Future<bool> _isLiked(String id) async {
    final res = await _repoPost.getLikePost(id);
    final idUser = FirebaseAuth.instance.currentUser!.uid;
    if (res != null) {
      final like = res.idsUser.firstWhereOrNull((e) => e == idUser);
      return like != null;
    }
    return false;
  }
}
