import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friendzone/data/models/post.dart';
import 'package:friendzone/data/models/user_model.dart';
import 'package:friendzone/data/repositories/post_repository.dart';
import 'package:friendzone/data/repositories/user_repository.dart';

part 'all_post_state.dart';

class AllPostCubit extends Cubit<AllPostState> {
  final PostRepository _repoPost;
  final UserRepository _userRepository;

  AllPostCubit(this._repoPost, this._userRepository) : super(AllPostInitial());

  getAllPost() async {
    final allPost = await _repoPost.getAllPost();
    final allUser = await _userRepository.getAllUser();
    emit(AllPostShow(allPost,allUser));
  }
}
