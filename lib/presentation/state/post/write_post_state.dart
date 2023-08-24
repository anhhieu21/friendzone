part of 'write_post_cubit.dart';

abstract class WritePostState extends Equatable {
  const WritePostState();

  @override
  List<Object> get props => [];
}

class WritePostInitial extends WritePostState {}

class WritePostChoseImage extends WritePostState {
  final File file;
  const WritePostChoseImage(this.file);
  @override
  List<Object> get props => [file];
}

class WritePostUploading extends WritePostState {
  const WritePostUploading();
  @override
  List<Object> get props => [];
}

class WritePostUploadSucces extends WritePostState {
  const WritePostUploadSucces();
  @override
  List<Object> get props => [];
}

class WritePostFaild extends WritePostState {
  const WritePostFaild();
  @override
  List<Object> get props => [];
}
