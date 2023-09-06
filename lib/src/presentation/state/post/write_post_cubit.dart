import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friendzone/src/data.dart';
import 'package:friendzone/src/domain.dart';
import 'package:image_picker/image_picker.dart';

part 'write_post_state.dart';

class WritePostCubit extends Cubit<WritePostState> {
  final PostRepository _postRepository;
  WritePostCubit(this._postRepository) : super(WritePostInitial());

  upPost(File file, String content, int like, bool visible,
      UserModel userModel) async {
    final success = await _postRepository.upPost(file, content,
        like: like, userModel: userModel, visible: visible);
    emit(const WritePostUploading());
    if (success) {
      emit(const WritePostUploadSucces());
    } else {
      emit(const WritePostFaild());
    }
  }

  choseImage() async {
    final picker = ImagePicker();
    XFile? image;
    image = await picker.pickImage(source: ImageSource.gallery);
    var file = File(image?.path ?? '');
    if (image != null) {
      emit(WritePostChoseImage(file));
    }
  }
}
