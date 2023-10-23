import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/message_entity.dart';
part 'chat_state.freezed.dart';

@freezed
abstract class ChatState with _$ChatState {
  const factory ChatState(List<MessageEntity> messages) = ChatStateData;
  const factory ChatState.loading() = ChatStateLoading;
  const factory ChatState.error(dynamic error) = ChatStateError;
}