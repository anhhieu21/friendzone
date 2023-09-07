// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:friendzone/src/domain/models/user_model.dart';

class Conversation {
  String id;
  List<String> participants;
  ChatMessage message;
  UserModel? user;
  Conversation({
    required this.id,
    required this.participants,
    required this.message,
    this.user,
  });
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'id': id});
    result.addAll({'message': message.toMap()});
    result.addAll({'participants': participants});
    return result;
  }

  factory Conversation.fromMap(DocumentSnapshot<Map<String, dynamic>> map) {
    return Conversation(
      id: map['id'] ?? '',
      message: ChatMessage.fromMap(map['message']),
      participants: List<String>.from((map['participants'] as List)),
    );
  }
}

class ChatMessage {
  String id;
  String idConversation;
  String sender;
  String receiver;
  String message;
  DateTime createdAt;
  ChatMessage({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.message,
    required this.createdAt,
    required this.idConversation,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'sender': sender});
    result.addAll({'receiver': receiver});
    result.addAll({'message': message});
    result.addAll({'createdAt': createdAt.millisecondsSinceEpoch});
    result.addAll({'idConversation': idConversation});

    return result;
  }

  factory ChatMessage.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> map) {
    return ChatMessage(
      id: map['id'] ?? '',
      sender: map['sender'] ?? '',
      receiver: map['receiver'] ?? '',
      message: map['message'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      idConversation: map['idConversation'],
    );
  }
  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] ?? '',
      sender: map['sender'] ?? '',
      receiver: map['receiver'] ?? '',
      message: map['message'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      idConversation: map['idConversation'],
    );
  }
}
