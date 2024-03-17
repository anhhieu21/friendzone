import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/domain/repositories/feed_repository.dart';

import 'package:image_picker/image_picker.dart';

part 'feed_state.dart';

class FeedCubit extends Cubit<FeedState> {
  final FeedRepository _repository;
  FeedCubit(
    this._repository,
  ) : super(FeedInitial()) {
    _init();
  }

  List<Feed> _feeds = [];
  XFile? image;
  _init() async {
    _feeds = await _repository.getStories();
    emit(FeedLoaded(_feeds));
  }

  getFeeds() async {
    _feeds = await _repository.getStories();
    emit(FeedLoaded(_feeds));
  }

  createFeed(UserModel userModel) async {
    if (image == null) return;
    emit(FeedLoading());
    final res = await _repository.createFeed(image!, userModel);
    if (res != null) {
      _feeds.add(res);
      emit(FeedLoaded(_feeds));

      return;
    } else {
      emit(FeedError());
    }
  }

  Future pickImage() async {
    image = null;
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    emit(FeedPickImage(File(image!.path)));
  }
}
