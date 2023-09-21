import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/domain/repositories/conversation_repository.dart';

part 'conversation_state.dart';

class ConversationCubit extends Cubit<ConversationState> {
  final ConversationRepository _conversationRepository;
  ConversationCubit(this._conversationRepository)
      : super(ConversationInitial()) {
    listenMessage();
  }

  sendMessage(UserModel receiver, String message, UserModel me) async {
    try {
      await _conversationRepository.sendMessage(receiver, message, me);
    } on FirebaseException catch (e, x) {
      log(x.toString());
    }
  }

  listMessage(String idReceiver) async {
    emit(const LoadingState(true));
    final listMessage =
        await _conversationRepository.getListMessage(idReceiver);
    listMessage.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    emit(ListMessageState(listMessage));
  }

  listenMessage() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('conversations')
        .snapshots()
        .listen((event) {
      final doc = event.docChanges.first.doc;
      if (!doc.exists) return;
      final message = Conversation.fromMap(doc);
      emit(MessageState((message.message)));
    });
  }
}
