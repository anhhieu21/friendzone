import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:friendzone/presentation/utils/formatter.dart';

class Post {
  String idUser;
  String content;
  String imageUrl;
  String author;
  String like;
  String createdAt;
  String? avartarAuthor;
  bool visible;
  Post(
      {required this.idUser,
      required this.content,
      required this.imageUrl,
      required this.author,
      required this.like,
      this.avartarAuthor,
      required this.visible,
      required this.createdAt});

  factory Post.fromFirestore(DocumentSnapshot doc) {
    Map postFromDB = doc.data() as Map;
    return Post(
        idUser: postFromDB['idUser'],
        content: postFromDB['content'],
        imageUrl: postFromDB['imageUrl'],
        author: postFromDB['author'],
        like: postFromDB['like'] ?? '0',
        visible: postFromDB['visible'],
        createdAt: Formatter.dateTime(postFromDB["createdAt"].toDate()));
  }
}
