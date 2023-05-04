part of 'signup_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}
class SignUpReq extends SignUpEvent {
  final String email;
  final String password;

  const SignUpReq(this.email, this.password);
}
