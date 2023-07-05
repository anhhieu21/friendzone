part of 'my_account_cubit.dart';

abstract class MyAccountState extends Equatable {
  const MyAccountState();

  @override
  List<Object> get props => [];
}

class MyAccountInitial extends MyAccountState {}

class MyDataState extends MyAccountState {
  final UserModel user;

  const MyDataState({required this.user});
  @override
  List<Object> get props => [user];
}

class ListPostState extends MyAccountState {
  final List<Post> myPostsPublic;
  final List<Post> myPostsPrivate;
  final List<Post> myPostsSave;

  const ListPostState(
      {required this.myPostsPublic,
      required this.myPostsPrivate,
      required this.myPostsSave});
  @override
  List<Object> get props => [myPostsPublic, myPostsPrivate, myPostsSave];
}

class UnSavePostState extends MyAccountState {}
