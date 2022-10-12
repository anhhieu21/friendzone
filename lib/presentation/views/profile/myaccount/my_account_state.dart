part of 'my_account_cubit.dart';

abstract class MyAccountState extends Equatable {
  const MyAccountState();

  @override
  List<Object> get props => [];
}

class MyAccountInitial extends MyAccountState {}

class MyAccountInfo extends MyAccountState {
  final Users user;
  final List<Post> myPosts;
  const MyAccountInfo(this.user,this.myPosts);

  @override
  List<Object> get props => [user,myPosts];
}
