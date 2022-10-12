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

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
        idUser: map["idUser"],
        avartar: map["avartar"],
        email: map["email"],
        name: map["name"],
        post: map["post"]);
  }
}

class MyPosts {
  String? path;
  MyPosts({this.path});
}
