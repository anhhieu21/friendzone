import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friendzone/data/models/post.dart';
import 'package:friendzone/domain/repositories/post_repository.dart';

part 'all_post_state.dart';

class AllPostCubit extends Cubit<AllPostState> {
  final PostRepository _repoPost;

  AllPostCubit(this._repoPost) : super(AllPostInitial());

  getAllPost() async {
    final allPost = await _repoPost.getAllPost();
    emit(AllPostShow(allPost));
  }
}
