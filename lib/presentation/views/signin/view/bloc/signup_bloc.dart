import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friendzone/domain/repositories/auth_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository _repository;
  SignUpBloc(this._repository) : super(SignUpInitial()) {
    on<SignUpReq>((event, emit) async {
      emit(SignUpLoading());
      try {
        final user =
            await _repository.signUpWithFireBase(event.email, event.password);
        if (user != null) {
          emit(SignUpSuccess(user));
        } else {
          emit(const  SignUpError('erro'));
        }
      } catch (e) {
        emit( SignUpError(e.toString()));
      }
    });
  }
}
