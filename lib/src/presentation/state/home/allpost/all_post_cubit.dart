import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friendzone/src/data.dart';
import 'package:friendzone/src/domain.dart';
part 'all_post_state.dart';

class AllPostCubit extends Cubit<AllPostState> {
  final PostRepository _repoPost;
  final UserRepository _userRepository;

  AllPostCubit(this._repoPost, this._userRepository) : super(AllPostInitial());

  getAllPost() async {
    final allPost = await _repoPost.getAllPost();
    final allUser = await _userRepository.getAllUser();
    emit(AllPostShow(allPost, allUser));
  }
}
