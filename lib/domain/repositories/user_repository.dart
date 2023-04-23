import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friendzone/data/models/user_model.dart';

class UserRepository {
  final firestore = FirebaseFirestore.instance.collection("users");
  Future<List<Users>> getAllUser() async {
    List<Users> listUser = [];
    QuerySnapshot querySnapshot = await firestore.get();
    for (var doc in querySnapshot.docs) {
      Users user = Users.fromFirestore(doc);
      listUser.add(user);
    }
    return listUser;
  }

  Future<Users> findMe() async {
    final querySnapshot =
        await firestore.doc(FirebaseAuth.instance.currentUser!.uid).get();
    Users user = Users.fromFirestore(querySnapshot);
    return user;
  }
}
