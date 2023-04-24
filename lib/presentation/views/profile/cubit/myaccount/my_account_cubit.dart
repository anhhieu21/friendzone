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
    List<Post> postsPrivate = [];
    List<Post> postsPublic = [];
    final user = await _repository.findMe();
    final myPost = await _repository.getMyPost();
    postsPrivate = myPost.where((e) => e.visible = false).toList();
    postsPublic = myPost.where((e) => e.visible = true).toList();
    emit(MyAccountInfo(user, postsPublic, postsPrivate));
  }
}
