import 'package:firebase_auth/firebase_auth.dart';
import 'package:friendzone/src/domain/repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _repository;
  const AuthUseCase(this._repository);

  // Future<User?> signUpWithFireBase(String email, String pass) async {
  //   return await _repository.signUpWithFireBase(email, pass);
  // }

  // Future signInWithSocial(User user) async {
  //   final res = await _repository.signInWithSocial(email, pass);
  // }

  // Future<User?> sendVerify(User? user) async {
  //   final res = await _repository.sendVerify(email, pass);
  // }

  // Future<User?> signInWithFireBase(String email, String password) async {
  //   final res = await _repository.signInWithFireBase(email, pass);
  // }

  // Future<void> signOut() async {
  //   final res = await _repository.signOut(email, pass);
  // }
}
