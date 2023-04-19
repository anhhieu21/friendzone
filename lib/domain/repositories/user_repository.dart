
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:friendzone/data/models/user_model.dart';

class UserRepository {
  final firestore = FirebaseFirestore.instance.collection("users");
  Future<List<Users>> getAllUser() async {
    List<Users> listUser = [];
    QuerySnapshot querySnapshot = await firestore.get();
    for (var doc in querySnapshot.docs) {
      
      Users user = Users.fromMap({
        "idUser": doc["idUser"],
        'avartar': doc["avartar"],
        "email": doc["email"],
        "name": doc["name"],
        "post":doc["posts"]
      });
      listUser.add(user);
    }
    return listUser;
  }
}
