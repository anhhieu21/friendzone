import 'dart:convert';

class Conversation {
  String id;
  List<String> ids;
  ChatMessage message;
  DateTime createdAt;
  DateTime updatedAt;
  Conversation({
    required this.id,
    required this.ids,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'ids': ids});
    result.addAll({'message': message.toMap()});
    result.addAll({'createdAt': createdAt.millisecondsSinceEpoch});
    result.addAll({'updatedAt': updatedAt.millisecondsSinceEpoch});

    return result;
  }

  factory Conversation.fromMap(Map<String, dynamic> map) {
    return Conversation(
      id: map['id'] ?? '',
      ids: List<String>.from(map['ids']),
      message: ChatMessage.fromMap(map['message']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Conversation.fromJson(String source) =>
      Conversation.fromMap(json.decode(source));
}

class ChatMessage {
  String id;
  String message;
  DateTime createdAt;
  String idUser;
  ChatMessage({
    required this.id,
    required this.message,
    required this.createdAt,
    required this.idUser,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'message': message});
    result.addAll({'createdAt': createdAt.millisecondsSinceEpoch});
    result.addAll({'idUser': idUser});

    return result;
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] ?? '',
      message: map['message'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      idUser: map['idUser'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) =>
      ChatMessage.fromMap(json.decode(source));
}
