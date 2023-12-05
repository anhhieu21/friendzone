// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:friendzone/src/domain.dart';

class PostCubitState {
  final String? error;
  final Post? post;
  final List<Comment>? comments;
  final bool? isSaved;
  final bool? isLiked;
  const PostCubitState({
    this.error,
    this.post,
    this.comments,
    this.isSaved,
    this.isLiked,
  });

  PostCubitState copyWith(
      {String? error,
      Post? post,
      List<Comment>? comments,
      bool? isSaved,
      bool? isLiked}) {
    return PostCubitState(
      error: error ?? this.error,
      post: post,
      comments: comments,
      isSaved: isSaved,
      isLiked: isLiked,
    );
  }
}
