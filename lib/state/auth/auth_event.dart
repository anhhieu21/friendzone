part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEvent(this.email, this.password);
}

class SignUpReq extends AuthEvent {
  final String email;
  final String password;

  const SignUpReq(this.email, this.password);
}

class SignOutRequested extends AuthEvent {}
