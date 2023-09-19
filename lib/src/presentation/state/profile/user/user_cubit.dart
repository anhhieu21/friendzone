import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friendzone/src/data.dart';
import 'package:friendzone/src/domain.dart';
part 'user_state.dart';

class UserPreviewCubit extends Cubit<UserpreviewState> {
  final UserRepository _repository;

  UserPreviewCubit(this._repository) : super(UserpreviewInitial());

  Future<UserModel?> loadInitialData(String idUser) async {
    try {
      emit(LoadingUserState());
      List<Post> postsPublic = [];
      final user = await _repository.findUser(idUser);
      final post = await _repository.getMyPost(idUser);
      final exists = await _repository.checkFollower(idUser);
      postsPublic = post.where((e) => e.visible = true).toList();

      emit(UserDataState(user!, postsPublic));
      emit(CheckFollowState(exists));
      return user;
    } catch (error) {
      return null;
    }
  }

  Future followUser(UserModel user, UserModel me) async {
    final following =
        Following(idUser: user.idUser, avatar: user.avartar, name: user.name);
    final follower =
        Follower(idUser: me.idUser, avatar: me.avartar, name: me.name);
    int countFollower = user.follower;
    int countFollowing = me.following;
    countFollower++;
    countFollowing++;
    final success = await _repository.followUser(
        following, follower, countFollower, countFollowing);
    if (success) {
      me.following = countFollowing;
      // emit(UserInfoState(me));
      emit(CheckFollowState(success));
    }

    return success;
  }

  Future getListFollower(String id) async {
    final followers = await _repository.getFollower(id);
    final followings = await _repository.getFollowing(id);
    emit(ListFollowerState(followers, followings));
  }
}
