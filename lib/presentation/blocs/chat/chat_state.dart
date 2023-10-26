import 'package:flutter/cupertino.dart';
import 'package:flutter_application/data/data_sources/paging/chat_data_source.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/entities/message_entity.dart';
part 'chat_state.freezed.dart';

enum ChatActionStatus {
  init,
  selectOption,
  sendingImage,
  sendingVideo,
  sendingFile,
  close
}

@freezed
abstract class ChatState with _$ChatState {
  const factory ChatState(TextEditingController textEditingController,
      MessageDataSource messageDataSource, ChatActionStatus chatActionStatus,
      {MessageEntity? messageEntity}) = ChatStateData;
  const factory ChatState.loading() = ChatStateLoading;
  const factory ChatState.error(dynamic error) = ChatStateError;
}
