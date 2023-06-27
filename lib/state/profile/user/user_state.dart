part of 'user_cubit.dart';

abstract class UserpreviewState extends Equatable {
  const UserpreviewState();

  @override
  List<Object> get props => [];
}

class UserpreviewInitial extends UserpreviewState {}

class LoadingState extends UserpreviewState {}

class UserDataState extends UserpreviewState {
  final UserModel user;
  final List<Post> post;
  const UserDataState(
    this.user,
    this.post,
  );
  @override
  List<Object> get props => [user, post];
}

class FollowState extends UserpreviewState {}

class ListFollowerState extends UserpreviewState {
  final List<Follower> listFollower;
  final List<Follower> listFollowing;
  const ListFollowerState(this.listFollower,this.listFollowing);
  @override
  List<Object> get props => [listFollower,listFollowing];
}
