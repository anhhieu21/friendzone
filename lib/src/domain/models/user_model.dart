import 'package:friendzone/src/utils.dart';

class UserModel {
  String idUser;
  String avartar;
  String email;
  List<dynamic>? post;
  String name;
  String background;
  String? bio;
  int follower;
  int following;
  String phone;
  UserModel({
    required this.idUser,
    required this.avartar,
    required this.email,
    required this.name,
    required this.background,
    this.post,
    this.bio,
    required this.follower,
    required this.following,
    required this.phone,
  });

  factory UserModel.fromMap(Map<dynamic, dynamic> map) {
    return UserModel(
      idUser: map["idUser"],
      avartar: map["avartar"].isEmpty ? urlAvatar : map["avartar"],
      email: map["email"],
      name: map["name"],
      post: map["post"],
      background: map["background"],
      bio: map["bio"],
      follower: map['follower'],
      following: map['following'],
      phone: map['phone'] ?? '0',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "avartar": avartar,
      "background": background,
      "email": email,
      "name": name,
      // "follower": follower,
      // "following": following,
      "phone": phone,
      "bio": bio,
    };
  }
}

class MyPosts {
  String? path;
  MyPosts({this.path});
}
