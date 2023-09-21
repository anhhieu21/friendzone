part of 'friendzone_bloc.dart';

@immutable
abstract class FriendzoneEvent extends Equatable {
  const FriendzoneEvent();
  @override
  List<Object?> get props => [];
}

class MyFriendEvent extends FriendzoneEvent {}
