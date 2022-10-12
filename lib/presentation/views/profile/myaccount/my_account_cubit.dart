import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friendzone/data/models/post.dart';
import 'package:friendzone/data/models/user_model.dart';

part 'my_account_state.dart';

class MyAccountCubit extends Cubit<MyAccountState> {
  MyAccountCubit() : super(MyAccountInitial());

  myAccountInfo(List<Users> users) async {
    List<Post> posts = [];
    Post? post;
    final user = users
        .firstWhere((e) => e.idUser == FirebaseAuth.instance.currentUser!.uid);
    if (user.post != null) {
      for (var path in user.post!) {
        final docRef = await FirebaseFirestore.instance.doc(path.path).get();
        post = Post.fromFirestore(docRef);
        posts.add(post);
      }
    }

    emit(MyAccountInfo(user, posts));
  }
}
