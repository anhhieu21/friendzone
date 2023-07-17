part of 'my_account_cubit.dart';

abstract class MyAccountState extends Equatable {
  const MyAccountState();

  @override
  List<Object> get props => [];
}

class MyAccountInitial extends MyAccountState {}

class MyDataState extends MyAccountState {
  final UserModel user;
  final List<Post> myPostsPublic;
  final List<Post> myPostsPrivate;
  final List<Post> myPostsSave;

  const MyDataState({required this.user,required this.myPostsPublic,
      required this.myPostsPrivate,
      required this.myPostsSave});
  @override
  List<Object> get props => [user,myPostsPublic, myPostsPrivate, myPostsSave];
}


