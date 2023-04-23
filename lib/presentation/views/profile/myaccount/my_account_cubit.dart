import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friendzone/data/models/post.dart';
import 'package:friendzone/data/models/user_model.dart';
import 'package:friendzone/domain/repositories/user_repository.dart';

part 'my_account_state.dart';

class MyAccountCubit extends Cubit<MyAccountState> {
  final UserRepository _repository;
  MyAccountCubit(this._repository) : super(MyAccountInitial());

  myAccountInfo() async {
    List<Post> posts = [];
    List<Post> postsPrivate = [];
    List<Post> postsPublic = [];
    Post? post;
    final fireStore = FirebaseFirestore.instance;
    final user = await _repository.findMe();

    if (user.post != null) {
      for (var path in user.post!) {
        final docRef = await fireStore.doc(path).get();
        post = Post.fromFirestore(docRef);
        posts.add(post);
      }
    }
    postsPrivate = posts.where((e) => e.visible = false).toList();
    postsPublic = posts.where((e) => e.visible = true).toList();
    emit(MyAccountInfo(user, postsPublic, postsPrivate));
  }
}
