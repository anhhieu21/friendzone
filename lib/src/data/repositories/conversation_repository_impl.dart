import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friendzone/src/domain/models/conversation.dart';
import 'package:friendzone/src/domain/models/user_model.dart';
import 'package:friendzone/src/domain/repositories/conversation_repository.dart';

class ConversationRepositoryImpl implements ConversationRepository {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance.currentUser;

  _createConversationForReceiver(
      String idReceiver, Conversation conversation, UserModel me,
      [bool isUpdate = false]) async {
    final docConversation = firestore
        .collection('users')
        .doc(idReceiver)
        .collection('conversations')
        .doc(conversation.message.idConversation);
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

  @override
  Future<void> sendMessage(
      UserModel receiver, String message, UserModel me) async {
    final ref = firestore
        .collection('users')
        .doc(me.idUser)
        .collection('conversations');
    String idConversation = _createIdConversation(me.idUser, receiver.idUser);
    final idsConversation = [
      idConversation,
      _createIdConversation(receiver.idUser, me.idUser)
    ];
    DocumentReference<Map<String, dynamic>> docConversation;
    bool exists = false;

    for (var e in idsConversation) {
      docConversation = ref.doc(e);
      final getDoc = await docConversation.get();
      exists = getDoc.exists;
      if (exists) {
        idConversation = e;
      }
    }
    docConversation = ref.doc(idConversation);
    final autoIdMessage = docConversation.collection('messages').doc().id;
    final lastMessage = ChatMessage(
        id: autoIdMessage,
        sender: me.idUser,
        receiver: receiver.idUser,
        message: message,
        createdAt: DateTime.now(),
        idConversation: idConversation);
    final conversation = Conversation(
      id: idConversation,
      participants: [me.idUser, receiver.idUser],
      message: lastMessage,
    );
    if (!exists) {
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

  @override
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

  @override
  Future<List<ChatMessage>> getListMessage(String idReceiver) async {
    final List<ChatMessage> list = [];
    final ref = firestore
        .collection('users')
        .doc(auth!.uid)
        .collection('conversations');
    final ids = [
      _createIdConversation(idReceiver, auth!.uid),
      _createIdConversation(auth!.uid, idReceiver)
    ];
    for (var id in ids) {
      final docConversation = await ref.doc(id).collection('messages').get();
      if (docConversation.docs.isNotEmpty) {
        final x = docConversation.docs
            .map((e) => ChatMessage.fromFirestore(e))
            .toList();
        list.addAll(x);
      }
    }
    return list;
  }

  String _createIdConversation(String idUser, String idMe) {
    return '${idUser.substring(0, 5)}${idMe.substring(0, 5)}';
  }
}
