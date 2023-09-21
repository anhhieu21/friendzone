import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/domain/models/user_model.dart';
import 'package:friendzone/src/domain/repositories/user_repository.dart';

part 'friendzone_event.dart';
part 'friendzone_state.dart';

class FriendzoneBloc extends Bloc<FriendzoneEvent, FriendzoneState> {
  final UserRepository _userRepository;
  FriendzoneBloc(this._userRepository) : super(FriendzoneInitial()) {
    on<MyFriendEvent>((event, emit) async {
      final friends = await _userRepository.getAllUser();
      final listFriend = friends
          .where((element) =>
              element.idUser != FirebaseAuth.instance.currentUser!.uid)
          .toList();
      emit(MyFriendState(listFriend));
    });
  }
}
