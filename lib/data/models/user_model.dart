import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String idUser;
  String avartar;
  String email;
  List<dynamic>? post;
  String name;
  Users(
      {required this.idUser,
      required this.avartar,
      required this.email,
      required this.name,
      this.post});

  factory Users.fromFirestore(DocumentSnapshot doc) {
    Map postFromDB = doc.data() as Map;
    return Users(
        idUser: postFromDB["idUser"],
        avartar: postFromDB["avartar"],
        email: postFromDB["email"],
        name: postFromDB["name"],
        post: postFromDB["posts"]);
  }
}

class MyPosts {
  String? path;
  MyPosts({this.path});
}
