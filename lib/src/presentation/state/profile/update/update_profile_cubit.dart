import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/domain/repositories/user_repository.dart';
import 'package:image_picker/image_picker.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UserRepository _repository;
  UpdateProfileCubit(this._repository) : super(UpdateProfileInitial());
  File? file;
  updateProfile(
      {required UserModel userModel, bool? isUpdateBackground}) async {
    emit(UpdatingProfile());
    final res = await _repository.updateProfile(
        user: userModel,
        file: file,
        isUpdateBackground: isUpdateBackground ?? false);
    if (res) {
      emit(const UpdateProfileSuccess());
    }
  }

  choseImage({bool isUpdateBackground = false}) async {
    final picker = ImagePicker();
    XFile? image;
    image = await picker.pickImage(source: ImageSource.gallery);
    file = File(image?.path ?? '');
    if (image != null) {
      emit(UpdateProfileChoseImage(file!, isUpdateBackground));
    }
  }
}
