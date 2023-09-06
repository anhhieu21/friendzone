part of 'update_profile_cubit.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object> get props => [];
}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileSuccess extends UpdateProfileState {
  const UpdateProfileSuccess();

  @override
  List<Object> get props => [];
}

class UpdateProfileChoseImage extends UpdateProfileState {
  final File file;
  const UpdateProfileChoseImage(this.file);

  @override
  List<Object> get props => [file];
}
