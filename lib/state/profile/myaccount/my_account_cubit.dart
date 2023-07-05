import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/data.dart';

part 'my_account_state.dart';

class MyAccountCubit extends Cubit<MyAccountState> {
  final UserRepository _repository;
  MyAccountCubit(this._repository) : super(MyAccountInitial());
  StreamController<Map<String, dynamic>> listenSavePost =
      StreamController<Map<String, dynamic>>.broadcast();
  List<Post> postsPrivate = [];
  List<Post> postsPublic = [];
  List<Post> postsSave = [];

  myAccountInfo(String idUser) async {
    final user = await _repository.findMe(idUser);
    final myPost = await _repository.getMyPost(idUser);
    postsSave = await _repository.getPostSave();
    postsPrivate = myPost.where((e) => e.visible = false).toList();
    postsPublic = myPost.where((e) => e.visible = true).toList();
    emit(MyDataState(user: user));
    listPost(idUser);
  }

  listPost(String idUser) async {
    final myPost = await _repository.getMyPost(idUser);
    postsSave = await _repository.getPostSave();
    postsPrivate = myPost.where((e) => e.visible = false).toList();
    postsPublic = myPost.where((e) => e.visible = true).toList();
    emit(ListPostState(
        myPostsPublic: postsPublic,
        myPostsPrivate: postsPrivate,
        myPostsSave: postsSave));
  }

  savePost(Post post) async {
    await _repository.savePost(post);
    listenSavePost.sink.add({'save': true, 'post': post});
  }

  unSavePost(Post post) async {
    await _repository.unSavePost(post);
    listenSavePost.sink.add({'save': false, 'post': post});
  }
}
