import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:friendzone/data/models/conversation.dart';
import 'package:friendzone/data/models/user_model.dart';
import 'package:friendzone/data/repositories/conversation_repository.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  final ConversationRepository _conversationRepository;
  ChatsCubit(
    this._conversationRepository,
  ) : super(ChatsInitial());

  sendMessage(UserModel receiver, String message, UserModel me) async {
    try {
      await _conversationRepository.sendMessage(receiver, message, me);
      await getListConversation();
    } on FirebaseException catch (e, x) {
      log(x.toString());
    }
  }

  getListConversation() async {
    try {
      final x = await _conversationRepository.getListConversation();
      emit(ListConversationState(x));
    } on FirebaseException catch (e, x) {
      log(x.toString());
    }
  }

  listenMessage(String idDoc) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('conversations')
        .doc(idDoc)
        .snapshots()
        .listen((event) {
      if (!event.exists) return;
      final message = Conversation.fromMap(event);
      emit(MessageState((message.message)));
    });
  }

  listMessage(String idReceiver) async {
    emit(const LoadingState(true));
    final listMessage =
        await _conversationRepository.getListMessage(idReceiver);
    listMessage.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    emit(ConversationState(listMessage));
  }
}
