import 'package:friendzone/data.dart';

class UserpreviewState {
  final bool isLoading;
  final String? error;
  final UserModel? user;
  final List<Post>? post;
  const UserpreviewState({
    this.isLoading = false,
    this.error,
    this.user,
    this.post,
  });

  UserpreviewState copyWith({
    UserModel? user,
    List<Post>? post,
    bool? isLoading,
    String? error,
  }) {
    return UserpreviewState(
      user: user ?? this.user,
      post: post ?? this.post,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
