import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:friendzone/common/constants/list_img_fake.dart';

class UserModel {
  String idUser;
  String avartar;
  String email;
  List<dynamic>? post;
  String name;
  String background;
  // bool followed;
  UserModel(
      {required this.idUser,
      required this.avartar,
      required this.email,
      required this.name,
      required this.background,
      this.post});

  factory UserModel.fromDocFireStore(DocumentSnapshot doc) {
    Map userFromDB = doc.data() as Map;
    return UserModel(
      idUser: userFromDB["idUser"],
      avartar:
          userFromDB["avartar"].isEmpty ? urlAvatar : userFromDB["avartar"],
      email: userFromDB["email"],
      name: userFromDB["name"],
      post: userFromDB["post"],
      background: userFromDB["background"].isEmpty
          ? urlAvatar
          : userFromDB["background"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "avartar": avartar,
      "email": email,
      "name": name,
      // "followed": followed,
    };
  }
}

class MyPosts {
  String? path;
  MyPosts({this.path});
}
