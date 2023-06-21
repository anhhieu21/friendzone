import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String id;
  String content;
  String idUser;
  String nameAuthor;
  DateTime createdAt;
  Comment({
    required this.id,
    required this.content,
    required this.idUser,
    required this.nameAuthor,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'id': id});
    result.addAll({'content': content});
    result.addAll({'idUser': idUser});
    result.addAll({'nameAuthor': nameAuthor});
    result.addAll({'createdAt': DateTime.now()});
    return result;
  }

  factory Comment.fromFirestore(DocumentSnapshot doc) {
    Map map = doc.data() as Map;
    return Comment(
        id: map['id'] ?? '',
        content: map['content'] ?? '',
        idUser: map['idUser'] ?? '',
        nameAuthor: map['nameAuthor'] ?? '',
        createdAt: map["createdAt"].toDate());
  }

  String toJson() => json.encode(toMap());

  // factory Comment.fromJson(String source) => Comment.fromMap(json.decode(source));
}
