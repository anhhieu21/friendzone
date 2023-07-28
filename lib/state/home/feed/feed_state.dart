part of 'feed_cubit.dart';

abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object> get props => [];
}

class FeedInitial extends FeedState {}

class FeedLoaded extends FeedState {
  final List<Feed> listFeed;
  const FeedLoaded(this.listFeed);

  @override
  List<Object> get props => [listFeed];
}

class FeedCreated extends FeedState {}

class FeedPickImage extends FeedState {
  final File file;

  const FeedPickImage(this.file);
  @override
  List<Object> get props => [file];
}

class FeedError extends FeedState {}
