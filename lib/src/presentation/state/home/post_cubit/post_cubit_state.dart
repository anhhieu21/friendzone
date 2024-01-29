import 'package:friendzone/src/domain.dart';

class PostCubitState {
  final String? error;
  final Post? post;
  final List<Comment>? comments;
  final bool? isSaved;
  const PostCubitState({
    this.error,
    this.post,
    this.comments,
    this.isSaved,
  });

  PostCubitState copyWith({
    String? error,
    Post? post,
    List<Comment>? comments,
    bool? isSaved,
  }) {
    return PostCubitState(
      error: error ?? this.error,
      post: post,
      comments: comments,
      isSaved: isSaved,
    );
  }
}
