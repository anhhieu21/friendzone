import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friendzone/data.dart';

part 'new_feeds_state.dart';

class NewFeedsCubit extends Cubit<NewFeedsState> {
  final PostRepository _repoPost;

  NewFeedsCubit(this._repoPost) : super(NewFeedsInitial());

  getAllPost() async {
    final allPost = await _repoPost.getAllPost();
    allPost.insert(
        0,
        Post(
            id: '0',
            idUser: '0',
            content: '0',
            imageUrl: '0',
            author: '0',
            like: '0',
            createdAt: '',
            visible: true));
    emit(NewFeedsShow(allPost));
  }
}
