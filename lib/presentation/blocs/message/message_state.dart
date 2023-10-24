import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/message_entity.dart';
part 'message_state.freezed.dart';

@freezed
abstract class MessageState with _$MessageState {
  const factory MessageState(MessageEntity data,
      {File? mediaFile, required bool mediaLoading}) = MessageStateData;
  const factory MessageState.loading() = MessageStateLoading;
  const factory MessageState.error(dynamic error) = MessageStateError;
}
