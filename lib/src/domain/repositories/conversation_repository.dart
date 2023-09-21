import 'package:friendzone/src/domain.dart';

abstract class ConversationRepository {
  Future<void> sendMessage(UserModel receiver, String message, UserModel me);

  Future<List<Conversation>> getListConversation();

  Future<List<ChatMessage>> getListMessage(String idReceiver);
}
