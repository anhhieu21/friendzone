import 'package:friendzone/data/models/post.dart';

class PostCubitState {
  final String? error;
  final Post? post;
  const PostCubitState({
    this.error,
    this.post,
  });

  PostCubitState copyWith({String? error, Post? post}) {
    return PostCubitState(error: error ?? this.error, post: post);
  }
}
