import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:friendzone/data.dart';

import 'post_cubit_state.dart';

class PostCubitCubit extends Cubit<PostCubitState> {
  PostRepository postRepository;
  PostCubitCubit(
    this.postRepository,
  ) : super( const PostCubitState());

  Future<void> likePost(Post post) async {
    try {
    final res=  await postRepository.likePost(post);
      emit(state.copyWith(post: res));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
    }
  }
}
