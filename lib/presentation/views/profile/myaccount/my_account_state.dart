part of 'my_account_cubit.dart';

abstract class MyAccountState extends Equatable {
  const MyAccountState();

  @override
  List<Object> get props => [];
}

class MyAccountInitial extends MyAccountState {}

class MyAccountInfo extends MyAccountState {
  final Users user;
  final List<Post> myPostsPublic;
  final List<Post> myPostsPrivate;
  const MyAccountInfo(this.user,this.myPostsPublic,this.myPostsPrivate);

  @override
  List<Object> get props => [user,myPostsPublic,myPostsPrivate];
}
