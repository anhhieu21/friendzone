part of 'signup_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final User user;

  const SignUpSuccess(this.user);
  @override
  List<Object> get props => [];
}

class SignUpLoading extends SignUpState {
  @override
  List<Object> get props => [];
}

// If any error occurs the state is changed to AuthError.
class  SignUpError extends SignUpState {
  final String error;

  const  SignUpError(this.error);
  @override
  List<Object> get props => [error];
}
