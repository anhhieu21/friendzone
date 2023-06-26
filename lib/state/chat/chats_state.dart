part of 'chats_cubit.dart';

abstract class ChatsState extends Equatable {
  const ChatsState();

  @override
  List<Object> get props => [];
}

class ChatsInitial extends ChatsState {}

class ListConversationState extends ChatsState {
  final List<Conversation> listConversation;
  const ListConversationState(
    this.listConversation,
  );
  @override
  List<Object> get props => [listConversation];
}

class ConversationState extends ChatsState {
  final List<ChatMessage> messages;
  const ConversationState(
    this.messages,
  );
  @override
  List<Object> get props => [messages];
}
class MessageState extends ChatsState {
  final ChatMessage message;
  const MessageState(
    this.message,
  );
  @override
  List<Object> get props => [message];
}
class LoadingState extends ChatsState {
  final bool isLoading;

  const LoadingState(this.isLoading);
  @override
  List<Object> get props => [isLoading];
}
