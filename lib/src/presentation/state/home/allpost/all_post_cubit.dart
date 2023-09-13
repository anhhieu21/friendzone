import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friendzone/src/data.dart';
import 'package:friendzone/src/domain.dart';
part 'all_post_state.dart';

class AllPostCubit extends Cubit<AllPostState> {
  final PostRepository _repoPost;

  AllPostCubit(this._repoPost) : super(AllPostInitial());
  List<Post> _allPost = [];
  getAllPost() async {
    _allPost = await _repoPost.getAllPost();
    emit(AllPostShow(_allPost));
  }

  Future getAllPostNext() async {
    final allPost = await _repoPost.getAllPostNext();
    _allPost.addAll(allPost);
    emit(AllPostShow(_allPost));
  }
}
