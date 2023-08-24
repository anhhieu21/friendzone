import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:friendzone/data/repositories/auth_repository.dart';
import 'package:friendzone/presentation/view.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;
  AuthBloc(this._repository) : super(AuthInitial()) {
    on<SignInEvent>((event, emit) async {
      emit(Loading());
      try {
        User? res;

        if (event.socialLoginMethod != null) {
          res = await _socialLogin(event.socialLoginMethod!);
        } else {
          res =
              await _repository.signInWithFireBase(event.email, event.password);
        }

        if (res != null) {
          emit(Authenticated());
        } else {
          emit(UnAuthenticated());
        }
      } on Exception catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    //

    on<SignOutRequested>((event, emit) async {
      emit(Loading());
      await _repository.signOut();
      emit(UnAuthenticated());
    });

    on<SignUpReq>((event, emit) async {
      emit(Loading());
      try {
        final user =
            await _repository.signUpWithFireBase(event.email, event.password);
        if (user != null) {
          emit(SignUpSuccess(user));
        } else {
          emit(const AuthError('erro'));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }
  Future<User?> _socialLogin(SocialLoginMethod socialLoginMethod) async {
    switch (socialLoginMethod) {
      case SocialLoginMethod.google:
        final res = await signInWithGoogle();
        await _repository.signInWithSocial(res.user!);
        return res.user;
      case SocialLoginMethod.facebook:
        final res = await signInWithFacebook();
        if (res == null) return null;
        await _repository.signInWithSocial(res.user!);
        return res.user;
      case SocialLoginMethod.apple:
        break;
      default:
        return null;
    }
    return null;
  }

  Future<UserCredential?> signInWithFacebook() async {
    // final LoginResult result = await FacebookAuth.instance.login();
    // if (result.status == LoginStatus.success) {
    //   // Create a credential from the access token
    //   final OAuthCredential credential =
    //       FacebookAuthProvider.credential(result.accessToken!.token);
    //   // Once signed in, return the UserCredential
    //   return await FirebaseAuth.instance.signInWithCredential(credential);
    // }
    return null;
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
