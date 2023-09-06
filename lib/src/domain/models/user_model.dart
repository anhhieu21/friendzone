import 'package:cloud_firestore/cloud_firestore.dart';
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

  factory UserModel.fromDocFireStore(DocumentSnapshot doc) {
    Map userFromDB = doc.data() as Map;
    return UserModel(
      idUser: userFromDB["idUser"],
      avartar:
          userFromDB["avartar"].isEmpty ? urlAvatar : userFromDB["avartar"],
      email: userFromDB["email"],
      name: userFromDB["name"],
      post: userFromDB["post"],
      background: userFromDB["background"],
      bio: userFromDB["bio"],
      follower: userFromDB['follower'],
      following: userFromDB['following'],
      phone: userFromDB['phone'] ?? '0',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "avartar": avartar,
      "email": email,
      "name": name,
      // "follower": follower,
      // "following": following,
      "phone": phone,
    };
  }
}

class MyPosts {
  String? path;
  MyPosts({this.path});
}
