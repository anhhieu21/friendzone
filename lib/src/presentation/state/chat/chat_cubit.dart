import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/data.dart';
import 'package:friendzone/src/domain.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ConversationRepository _conversationRepository;
  ChatCubit(
    this._conversationRepository,
  ) : super(ChatsInitial());

  

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

  
}
