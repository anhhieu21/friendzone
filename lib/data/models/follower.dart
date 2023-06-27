class Follower {
  String idUser;
  String avatar;
  String name;
  Follower({
    required this.idUser,
    required this.avatar,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'idUser': idUser});
    result.addAll({'avatar': avatar});
    result.addAll({'name': name});

    return result;
  }

  factory Follower.fromMap(Map<String, dynamic> map) {
    return Follower(
      idUser: map['idUser'] ?? '',
      avatar: map['avatar'] ?? '',
      name: map['name'] ?? '',
    );
  }
}

class Following extends Follower {
  Following(
      {required super.idUser, required super.avatar, required super.name});
}
