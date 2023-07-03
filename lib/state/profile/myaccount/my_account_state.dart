part of 'my_account_cubit.dart';

class MyAccountState {
  final UserModel? user;
  final List<Post>? myPostsPublic;
  final List<Post>? myPostsPrivate;
  const MyAccountState({this.user, this.myPostsPublic, this.myPostsPrivate});

  MyAccountState copyWith(
      {required UserModel user,
      required List<Post> myPostsPublic,
      required List<Post> myPostsPrivate}) {
    return MyAccountState(
        user: user,
        myPostsPublic: myPostsPublic,
        myPostsPrivate: myPostsPrivate);
  }
}
