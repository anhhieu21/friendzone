import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/domain/repositories/user_repository.dart';

part 'my_account_state.dart';

class MyAccountCubit extends Cubit<MyAccountState> {
  final UserRepository _repository;
  MyAccountCubit(this._repository) : super(MyAccountInitial());
  List<Post> _postsPrivate = [];
  List<Post> _postsPublic = [];
  List<Post> _postsSave = [];
  UserModel? _user;

  Future<bool> myAccountInfo(String idUser) async {
    _postsPrivate = [];
    _postsPublic = [];
    _postsSave = [];
    _user = await _repository.findUser(idUser);

    if (_user == null) return false;
    final myPost = await _repository.getMyPost(idUser);
    _postsSave = await _repository.getPostSave();
    _postsPrivate = myPost.where((e) => e.visible = false).toList();
    _postsPublic = myPost.where((e) => e.visible = true).toList();
    _emitData();
    return true;
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
