import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friendzone/domain/repositories/post_repository.dart';

part 'write_post_state.dart';

class WritePostCubit extends Cubit<WritePostState> {
  final PostRepository _postRepository;
  WritePostCubit(this._postRepository) : super(WritePostInitial());

  upPost(String content,int like) async {
    final success = await _postRepository.upPost(content,like: like);
    emit(const WritePostUploading());

    if (success != null && success) {
      emit(const WritePostUploadSucces());
    } else {
      emit(const WritePostFaild());
    }
  }
}
