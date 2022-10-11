import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit() : super(ChatsInitial());
}
