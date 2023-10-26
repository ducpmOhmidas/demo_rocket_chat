import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application/application/services/local_service.dart';
import 'package:flutter_application/data/data_sources/paging/chat_data_source.dart';
import 'package:flutter_application/data/dtos/attachment_dto.dart';
import 'package:flutter_application/data/dtos/message_dto.dart';
import 'package:flutter_application/data/dtos/profile_dto.dart';
import 'package:flutter_application/presentation/blocs/chat/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tuple/tuple.dart';

import '../../../domain/entities/message_entity.dart';
import '../../../domain/entities/room_entity.dart';

class ChatBloc extends Cubit<ChatState> {
  ChatBloc({required LocalService localService, required RoomEntity roomEntity})
      : _localService = localService,
        _roomEntity = roomEntity,
        super(ChatStateData(
            TextEditingController(),
            MessageDataSource(
                roomId: roomEntity.id, roomType: roomEntity.type ?? 'c'),
            ChatActionStatus.init));

  LocalService _localService;
  RoomEntity _roomEntity;

  void selectOption() {
    emit(state.mapOrNull((value) =>
            value.copyWith(chatActionStatus: ChatActionStatus.selectOption)) ??
        state);
  }

  Future pickFile({
    ImageSource source = ImageSource.camera,
    required AttachmentStatus status,
  }) async {
    final file = await _localService.onPickFile(source: source, status: status);
    emit(state.mapOrNull((value) =>
            value.copyWith(chatActionStatus: ChatActionStatus.close)) ??
        state);
    if (file != null) {
      final ChatActionStatus chatActionStatus;
      switch (status) {
        case AttachmentStatus.image:
          chatActionStatus = ChatActionStatus.sendingImage;
          break;
        case AttachmentStatus.video:
          chatActionStatus = ChatActionStatus.sendingVideo;
          break;
        default:
          chatActionStatus = ChatActionStatus.sendingImage;
          break;
      }
      final fileSize = await file.length();
      var fileUrl = file.path;
      var fileFormat;
      var titleLink;
      var title = file.path.split('/').last;
      var type;
      final messageDto = getMessageDto();
      final newMessage = messageDto.copyWith(attachmentsRM: [
        AttachmentDto(
            id: DateTime.now().hashCode,
            audioSize: fileSize,
            fileSize: fileSize,
            imageSize: fileSize,
            audioUrl: fileUrl,
            fileDescription: '',
            fileFormat: fileFormat,
            imageUrl: fileUrl,
            title: title,
            titleLink: titleLink,
            type: type,
            videoUrl: fileUrl)
      ]);
      emit(state.mapOrNull((value) => value.copyWith(
              chatActionStatus: chatActionStatus, messageEntity: newMessage)) ??
          state);
    }
    log('pickFile: ${file?.path}');
  }

  MessageDto getMessageDto() {
    final currentMessage = state.mapOrNull((value) => value.messageEntity);
    return MessageDto(
        id: currentMessage?.id ?? DateTime.now().hashCode.toString(),
        rid: currentMessage?.rid ?? _roomEntity.id,
        mentionsRM: currentMessage?.userMentions
            ?.map((e) => ProfileDto(e.name, e.id))
            .toList(),
        msg: currentMessage?.msg,
        userInforRM: ProfileDto(currentMessage?.userInfor?.name,
            currentMessage?.userInfor?.id ?? ''),
        attachmentsRM: currentMessage?.attachments
            ?.map((e) => AttachmentDto(
                id: e.id,
                audioSize: e.audioSize,
                fileSize: e.fileSize,
                imageSize: e.imageSize,
                audioUrl: e.audioUrl,
                fileDescription: e.fileDescription,
                fileFormat: e.fileFormat,
                imageUrl: e.imageUrl,
                title: e.title,
                titleLink: e.titleLink,
                type: e.type,
                videoUrl: e.videoUrl))
            .toList());
  }

  void closeDialog() {
    emit(state.mapOrNull((value) =>
            value.copyWith(chatActionStatus: ChatActionStatus.init,)) ??
        state);
  }
}
