import 'package:flutter_application/presentation/blocs/chat/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Cubit<ChatState> {
  ChatBloc({required int roomId}) : super(ChatState.loading());

}