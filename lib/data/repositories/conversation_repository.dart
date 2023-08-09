import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friendzone/data/models/conversation.dart';
import 'package:friendzone/data/models/user_model.dart';

class ConversationRepository {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance.currentUser;

  _createConversationForReceiver(
      String idReceiver, Conversation conversation, UserModel me,
      [bool isUpdate = false]) async {
    conversation.receiver = me.name;
    conversation.image = me.avartar;
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

  sendMessage(UserModel receiver, String message, UserModel me) async {
    final docConversation = firestore
        .collection('users')
        .doc(auth!.uid)
        .collection('conversations')
        .doc(receiver.idUser);
    final getDoc = await docConversation.get();
    final autoIdMessage = docConversation.collection('messages').doc().id;
    final lastMessage = ChatMessage(
        id: autoIdMessage,
        sender: auth!.uid,
        receiver: receiver.idUser,
        message: message,
        createdAt: DateTime.now());
    final conversation = Conversation(
        id: receiver.idUser,
        message: lastMessage,
        receiver: receiver.name,
        image: receiver.avartar);

    if (!getDoc.exists) {
      await docConversation.set(conversation.toMap());
      await _createConversationForReceiver(receiver.idUser, conversation, me);
    } else {
      await docConversation.update(conversation.toMap());
      await _createConversationForReceiver(
          receiver.idUser, conversation, me, true);
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
