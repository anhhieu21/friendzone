import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friendzone/data/models/conversation.dart';

class ConversationRepository {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance.currentUser;

  _createConversationForReceiver(String idReceiver, Conversation conversation,
      [bool isUpdate = false]) async {
    final docConversation = firestore
        .collection('users')
        .doc(idReceiver)
        .collection('conversations')
        .doc(auth!.uid);
    if (isUpdate) {
      await docConversation.update(conversation.toMap());
    } else {
      await docConversation.set(conversation.toMap());
    }
    await docConversation
        .collection('messages')
        .doc(conversation.message.id)
        .set(conversation.message.toMap());
  }

  sendMessage(String idReceiver, String message) async {
    final docConversation = firestore
        .collection('users')
        .doc(auth!.uid)
        .collection('conversations')
        .doc(idReceiver);
    final getDoc = await docConversation.get();
    final autoIdMessage = docConversation.collection('messages').doc().id;
    final lastMessage = ChatMessage(
        id: autoIdMessage,
        sender: auth!.uid,
        receiver: idReceiver,
        message: message,
        createdAt: DateTime.now());
    final conversation = Conversation(id: idReceiver, message: lastMessage);

    if (!getDoc.exists) {
      await docConversation.set(conversation.toMap());
      await _createConversationForReceiver(idReceiver, conversation);
    } else {
      await docConversation.update(conversation.toMap());
      await _createConversationForReceiver(idReceiver, conversation, true);
    }
    await docConversation
        .collection('messages')
        .doc(autoIdMessage)
        .set(lastMessage.toMap());
  }

  Future<List<Conversation>> getListConversation() async {
    final List<Conversation> list = [];
    final docConversation = await firestore
        .collection('users')
        .doc(auth!.uid)
        .collection('conversations')
        .get();
    for (var element in docConversation.docs) {
      final x = Conversation.fromMap(element);
      list.add(x);
    }
    return list;
  }

  Future<List<ChatMessage>> getListMessage(String idReceiver) async {
    final List<ChatMessage> list = [];
    final docConversation = await firestore
        .collection('users')
        .doc(auth!.uid)
        .collection('conversations')
        .doc(idReceiver)
        .collection('messages')
        .get();
    for (var element in docConversation.docs) {
      final x = ChatMessage.fromFirestore(element);
      list.add(x);
    }
    return list;
  }
}
