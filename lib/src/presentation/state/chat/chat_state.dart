part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatsInitial extends ChatState {}

class ListConversationState extends ChatState {
  final List<Conversation> listConversation;
  const ListConversationState(
    this.listConversation,
  );
  @override
  List<Object> get props => [listConversation];
}

class MessageState extends ChatState {
  final ChatMessage message;
  const MessageState(
    this.message,
  );
  @override
  List<Object> get props => [message];
}

class LoadingState extends ChatState {
  final bool isLoading;

  const LoadingState(this.isLoading);
  @override
  List<Object> get props => [isLoading];
}
