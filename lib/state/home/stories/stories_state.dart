part of 'stories_cubit.dart';

abstract class StoriesState extends Equatable {
  const StoriesState();

  @override
  List<Object> get props => [];
}

class StoriesInitial extends StoriesState {}

class StoriesLoaded extends StoriesState {
  final List<Story> stories;
  const StoriesLoaded(this.stories);

  @override
  List<Object> get props => [stories];
}

class StoryCreated extends StoriesState {}
class StoriesError extends StoriesState {}
