import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/domain/repositories/conversation_repository.dart';
import 'package:friendzone/src/domain/repositories/user_repository.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ConversationRepository _conversationRepository;
  final UserRepository _userRepository;
  ChatCubit(
    this._conversationRepository,
    this._userRepository,
  ) : super(ChatsInitial()) {
    print('object');
    getListConversation();
  }

  getListConversation() async {
    try {
      final x = await _conversationRepository.getListConversation();
      for (var element in x) {
        final idUser = element.participants
            .firstWhere((e) => e != FirebaseAuth.instance.currentUser!.uid);
        final user = await _userRepository.findUser(idUser);
        element.user = user;
      }
      emit(ListConversationState(x));
    } on FirebaseException catch (e, x) {
      log(x.toString());
    }
  }
}
