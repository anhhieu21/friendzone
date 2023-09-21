import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User?> signUpWithFireBase(String email, String pass);

  Future signInWithSocial(User user);

  Future<User?> sendVerify(User? user);

  Future<User?> signInWithFireBase(String email, String password);

  Future<void> signOut();
}
