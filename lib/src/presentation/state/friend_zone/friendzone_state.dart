part of 'friendzone_bloc.dart';

abstract class FriendzoneState extends Equatable {
  const FriendzoneState();

  @override
  List<Object> get props => [];
}

class FriendzoneInitial extends FriendzoneState {}

class MyFriendState extends FriendzoneState {
  final List<UserModel> list;

  const MyFriendState(this.list);

  @override
  List<Object> get props => [list];
}
