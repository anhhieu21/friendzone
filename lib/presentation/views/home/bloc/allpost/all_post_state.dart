part of 'all_post_cubit.dart';

abstract class AllPostState extends Equatable {
  const AllPostState();

  @override
  List<Object> get props => [];
}

class AllPostInitial extends AllPostState {}

class AllPostShow extends AllPostState {
  final List<Post> listPost;
  const AllPostShow(this.listPost);

  @override
  List<Object> get props => [listPost];
}
