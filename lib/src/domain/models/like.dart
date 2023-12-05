import 'package:cloud_firestore/cloud_firestore.dart';

class Like {
  String id;
  List<String> idsUser;
  Like({
    required this.id,
    required this.idsUser,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'idsUser': idsUser});

    return result;
  }

  factory Like.fromFirestore(DocumentSnapshot doc) {
    Map map = doc.data() as Map;
    return Like(
      id: map['id'] ?? '',
      idsUser: List<String>.from(map['idsUser'] ?? []),
    );
  }
}
