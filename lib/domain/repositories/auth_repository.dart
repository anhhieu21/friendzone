import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final storageRef = FirebaseStorage.instance.ref();
  Future<User?> signUpWithFireBase(String email, String pass) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: pass);
      final user = await sendVerify(userCredential.user);
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

  Future<void> signInWithFireBase(
    String email,
    String password,
  ) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> updateProfile(
      {String? displayName, String? phone, File? file}) async {
    try {
      String? urlImage;
      if (file != null) {
        final upLoad =
            storageRef.child('images/${basename(file.path)}').putFile(file);

        upLoad.snapshotEvents.listen((event) async {
          switch (event.state) {
            case TaskState.paused:
              log("Upload is paused.");
              break;
            case TaskState.running:
              final progress =
                  100.0 * (event.bytesTransferred / event.totalBytes);
              log("Upload is $progress% complete.");
              break;
            case TaskState.success:
              urlImage = await event.ref.getDownloadURL();
              if (urlImage != null) {
                await _firebaseAuth.currentUser!.updatePhotoURL(urlImage);
              }
              break;

            case TaskState.canceled:
              log("Upload was canceled");
              break;
            case TaskState.error:
              break;
          }
        });
      }
      if (displayName!.isNotEmpty) {
        await _firebaseAuth.currentUser!.updateDisplayName(displayName);
      }
      // if (phone!.isNotEmpty) {
      //   await _firebaseAuth.currentUser!.updatePhoneNumber(ph);
      // }
  
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
