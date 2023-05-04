import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friendzone/data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;
  AuthBloc(this._repository) : super(AuthInitial()) {
    on<SignInEvent>((event, emit) async {
      emit(Loading());
      try {
        final res =
            await _repository.signInWithFireBase(event.email, event.password);
        if (res) {
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
  }
}
