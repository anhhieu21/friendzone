import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/data.dart';
import 'package:friendzone/state/profile/user/user_state.dart';

class UserPreviewCubit extends Cubit<UserpreviewState> {
  final UserRepository _repository;

  UserPreviewCubit(this._repository)
      : super(const UserpreviewState(isLoading: true));

  Future<UserModel?> loadInitialData(String idUser) async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));
      List<Post> postsPublic = [];
      final user = await _repository.findMe(idUser);
      final post = await _repository.getMyPost(idUser);
      postsPublic = post.where((e) => e.visible = true).toList();
      emit(state.copyWith(user: user, post: postsPublic));
      emit(state.copyWith(isLoading: false));
      return user;
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
      return null;
    }
  }
}
