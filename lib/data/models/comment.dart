import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:friendzone/presentation/utils/formatter.dart';

class Comment {
  String id;
  String content;
  String idUser;
  String nameAuthor;
  String createdAt;
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
    return result;
  }

  factory Comment.fromFirestore(DocumentSnapshot doc) {
    Map map = doc.data() as Map;
    return Comment(
        id: map['id'] ?? '',
        content: map['content'] ?? '',
        idUser: map['idUser'] ?? '',
        nameAuthor: map['nameAuthor'] ?? '',
        createdAt: Formatter.dateTime(map["createdAt"].toDate()));
  }

  String toJson() => json.encode(toMap());

  // factory Comment.fromJson(String source) => Comment.fromMap(json.decode(source));
}
