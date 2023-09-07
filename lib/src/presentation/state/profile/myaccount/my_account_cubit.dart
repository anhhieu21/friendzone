import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/data.dart';
import 'package:friendzone/src/domain.dart';

part 'my_account_state.dart';

class MyAccountCubit extends Cubit<MyAccountState> {
  final UserRepository _repository;
  MyAccountCubit(this._repository) : super(MyAccountInitial());
  List<Post> _postsPrivate = [];
  List<Post> _postsPublic = [];
  List<Post> _postsSave = [];
  UserModel? _user;

  myAccountInfo(String idUser) async {
    _user = await _repository.findUser(idUser);
    final myPost = await _repository.getMyPost(idUser);
    _postsSave = await _repository.getPostSave();
    _postsPrivate = myPost.where((e) => e.visible = false).toList();
    _postsPublic = myPost.where((e) => e.visible = true).toList();
    _emitData();
  }

  Future<bool> savePost(Post post) async {
    final isSaved = await _repository.savePost(post);
    _handleSavePost();
    return isSaved;
  }

  Future unSavePost(Post post) async {
    await _repository.unSavePost(post);
    _handleSavePost();
  }

  _handleSavePost() async {
    _postsSave = await _repository.getPostSave();
    _emitData();
  }

  _emitData() => emit(MyDataState(
      user: _user!,
      myPostsPublic: _postsPublic,
      myPostsPrivate: _postsPrivate,
      myPostsSave: _postsSave));
}
