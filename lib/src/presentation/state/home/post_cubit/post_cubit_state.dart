import 'package:friendzone/src/domain.dart';

class PostCubitState {
  final String? error;
  final Post? post;
  final List<Comment>? comments;
  const PostCubitState({
    this.error,
    this.post,
    this.comments,
  });

  PostCubitState copyWith(
      {String? error, Post? post, List<Comment>? comments}) {
    return PostCubitState(
        error: error ?? this.error, post: post, comments: comments);
  }
}
