part of 'new_feeds_cubit.dart';

abstract class NewFeedsState extends Equatable {
  const NewFeedsState();

  @override
  List<Object> get props => [];
}

class NewFeedsInitial extends NewFeedsState {}

class NewFeedsShow extends NewFeedsInitial {
  final List<Post> listPost;
  NewFeedsShow(this.listPost);

  @override
  List<Object> get props => [listPost];
}
