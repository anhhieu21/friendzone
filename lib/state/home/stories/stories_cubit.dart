import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:friendzone/data/models/story.dart';
import 'package:friendzone/data/repositories/stories_repository.dart';

part 'stories_state.dart';

class StoriesCubit extends Cubit<StoriesState> {
  final StoriesRepository _repository;
  StoriesCubit(
    this._repository,
  ) : super(StoriesInitial());

  List<Story> _stories = [];

  loadStories() async {
    _stories = await _repository.getStories();
    emit(StoriesLoaded(_stories));
  }

  createStory(Story story) async {
    final success = await _repository.createStory(story);
    if (success) {
      _stories.add(story);
      emit(StoriesLoaded(_stories));
      emit(StoryCreated());
      return;
    } else {
      emit(StoriesError());
    }
  }
}
