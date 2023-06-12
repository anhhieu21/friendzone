import 'dart:convert';

class Like {
  String id;
  String idUser;
  int idPost;
  Like({
    required this.id,
    required this.idUser,
    required this.idPost,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'idUser': idUser});
    result.addAll({'idPost': idPost});

    return result;
  }

  factory Like.fromMap(Map<String, dynamic> map) {
    return Like(
      id: map['id'] ?? '',
      idUser: map['idUser'] ?? '',
      idPost: map['idPost']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Like.fromJson(String source) => Like.fromMap(json.decode(source));
}
