import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:friendzone/main.dart';
import 'package:friendzone/src/data.dart';
import 'package:friendzone/src/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {


  final _firebaseAuth = FirebaseAuth.instance;
  final storageRef = FirebaseStorage.instance.ref();
  final fireStore = FirebaseFirestore.instance.collection('users');
  User? user;
  AuthRepositoryImpl() {
    final userFromFireBaseAuth = FirebaseAuth.instance.currentUser;
    if (userFromFireBaseAuth != null) {
      user = userFromFireBaseAuth;
    }
  }
  @override
  Future<User?> signUpWithFireBase(String email, String pass) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: pass);
      final res = await sendVerify(userCredential.user);
      user = res;
      await UserRepositoryImpl().insertUserToFireStore(user!);

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

  @override
  Future signInWithSocial(User user) async {
    await UserRepositoryImpl().insertUserToFireStore(user);
  }

  @override
  Future<User?> sendVerify(User? user) async {
    await user?.sendEmailVerification();
    return user;
  }

  @override
  Future<User?> signInWithFireBase(
    String email,
    String password,
  ) async {
    try {
      final res = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      user = res.user;
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

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await googleSignIn.signOut();
    } catch (e) {
      print(e.toString());
      await googleSignIn.signOut();
    }
  }
}
