part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}
class AuthInitialEvent extends AuthEvent{}
class SignInEvent extends AuthEvent {
  final String email;
  final String password;
  final SocialLoginMethod? socialLoginMethod;
  const SignInEvent(this.email, this.password, {this.socialLoginMethod});
}

class SignUpReq extends AuthEvent {
  final String email;
  final String password;

  const SignUpReq(this.email, this.password);
}

class SignOutRequested extends AuthEvent {}
