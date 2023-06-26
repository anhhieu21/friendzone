import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  String id;
  ChatMessage message;
  Conversation({
    required this.id,
    required this.message,
  });
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'id': id});
    result.addAll({'message': message.toMap()});
    return result;
  }

  factory Conversation.fromMap(DocumentSnapshot<Map<String, dynamic>> map) {
    return Conversation(
      id: map['id'] ?? '',
      message: ChatMessage.fromMap(map['message']),
    );
  }
}

class ChatMessage {
  String id;
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
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'sender': sender});
    result.addAll({'receiver': receiver});
    result.addAll({'message': message});
    result.addAll({'createdAt': createdAt.millisecondsSinceEpoch});

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
    );
  }
  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] ?? '',
      sender: map['sender'] ?? '',
      receiver: map['receiver'] ?? '',
      message: map['message'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }
}
