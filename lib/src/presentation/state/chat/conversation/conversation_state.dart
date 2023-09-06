part of 'conversation_cubit.dart';

class ConversationState extends Equatable {
  const ConversationState();

  @override
  List<Object> get props => [];
}

class ConversationInitial extends ConversationState {}

class ListMessageState extends ConversationState {
  final List<ChatMessage> messages;
  const ListMessageState(
    this.messages,
  );
  @override
  List<Object> get props => [messages];
}

class MessageState extends ConversationState {
  final ChatMessage message;
  const MessageState(
    this.message,
  );
  @override
  List<Object> get props => [message];
}

class LoadingState extends ConversationState {
  final bool isLoading;

  const LoadingState(this.isLoading);
  @override
  List<Object> get props => [isLoading];
}
