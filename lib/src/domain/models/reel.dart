import 'user_model.dart';

class Reel {
  String id;
  String idUser;
  String link;
  UserModel? userModel;

  Reel({required this.id, required this.idUser, required this.link});
  factory Reel.fromMap(Map<String, dynamic> map) =>
      Reel(id: map['id'], idUser: map['idUser'], link: map['link']);

  Map<String, dynamic> toMap() => {
        'id': id,
        'idUser': idUser,
        'link': link,
      };
}
