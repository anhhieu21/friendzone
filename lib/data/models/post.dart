class Post {
  String idUser;
  String content;
  String imageUrl;
  String email;
  String like;
  DateTime createdAt;

  Post(
      {required this.idUser,
      required this.content,
      required this.imageUrl,
      required this.email,
      required this.like,
      required this.createdAt});

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
        idUser: map['idUser'],
        content: map["content"],
        imageUrl: map["imageUrl"],
        email: map["email"],
        like: map["like"],
        createdAt: map["createdAt"]);
  }
}
