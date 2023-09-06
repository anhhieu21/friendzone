import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friendzone/src/data.dart';
import 'package:image_picker/image_picker.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UserRepository _repository;
  UpdateProfileCubit(this._repository) : super(UpdateProfileInitial());

  updateProfile({String? displayName, String? phone}) async {
    File? file;
    final state = this.state; //
    if (state is UpdateProfileChoseImage) {
      file = state.file;
    }
    final res = await _repository.updateProfile(
        displayName: displayName, phone: phone, file: file);
    if (res) {
      emit(const UpdateProfileSuccess());
    }
  }

  choseImage() async {
    final picker = ImagePicker();
    XFile? image;
    image = await picker.pickImage(source: ImageSource.gallery);
    var file = File(image?.path ?? '');
    if (image != null) {
      emit(UpdateProfileChoseImage(file));
    }
  }
}
