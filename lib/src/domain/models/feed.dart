import 'package:cloud_firestore/cloud_firestore.dart';

class Feed {
  String id;
  String idUser;
  List<String> imagesUrl;
  String author;
  String createdAt;
  String avartarAuthor;
  Feed({
    required this.id,
    required this.idUser,
    required this.imagesUrl,
    required this.author,
    required this.createdAt,
    required this.avartarAuthor,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idUser': idUser,
      'imagesUrl': imagesUrl,
      'author': author,
      'createdAt': createdAt,
      'avartarAuthor': avartarAuthor,
    };
  }

  factory Feed.fromMap(DocumentSnapshot doc) {
    Map postFromDB = doc.data() as Map;
    return Feed(
      id: postFromDB['id'] as String,
      idUser: postFromDB['idUser'] as String,
      imagesUrl: List<String>.from(postFromDB['imagesUrl']),
      author: postFromDB['author'] as String,
      createdAt: postFromDB['createdAt'] as String,
      avartarAuthor: postFromDB['avartarAuthor'] as String,
    );
  }
}
