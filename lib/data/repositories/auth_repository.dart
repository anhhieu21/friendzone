import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:friendzone/data/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthRepository {
  static final instance = AuthRepository._();

  final _firebaseAuth = FirebaseAuth.instance;
  final storageRef = FirebaseStorage.instance.ref();
  final fireStore = FirebaseFirestore.instance.collection('users');
  User? user;
  AuthRepository._() {
    final userFromFireBaseAuth = FirebaseAuth.instance.currentUser;
    if (userFromFireBaseAuth != null) {
      user = userFromFireBaseAuth;
    }
  }
  Future<User?> signUpWithFireBase(String email, String pass) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: pass);
      final res = await sendVerify(userCredential.user);
      user = res;
      await UserRepository().insertUserToFireStore(user!);

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  Future<User?> sendVerify(User? user) async {
    await user?.sendEmailVerification();
    return user;
  }

  Future<User?> signInWithFireBase(
    String email,
    String password,
  ) async {
    try {
      final res = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return res.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == "unknown") {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
