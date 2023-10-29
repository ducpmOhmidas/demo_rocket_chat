import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/application/services/chat_service.dart';
import 'package:flutter_application/application/services/local_service.dart';
import 'package:flutter_application/data/data_sources/paging/chat_data_source.dart';
import 'package:flutter_application/data/dtos/attachment_dto.dart';
import 'package:flutter_application/data/dtos/message_dto.dart';
import 'package:flutter_application/data/dtos/profile_dto.dart';
import 'package:flutter_application/presentation/blocs/chat/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';

import '../../../domain/entities/message_entity.dart';
import '../../../domain/entities/room_entity.dart';

class ChatBloc extends Cubit<ChatState> {
  ChatBloc(
      {required LocalService localService,
      required ChatService chatService,
      required RoomEntity roomEntity})
      : _localService = localService,
        _chatService = chatService,
        _roomEntity = roomEntity,
        super(ChatStateData(
            TextEditingController(),
            MessageDataSource(
                roomId: roomEntity.id, roomType: roomEntity.type ?? 'c'),
            ChatActionStatus.init));

  LocalService _localService;
  ChatService _chatService;
  RoomEntity _roomEntity;
  FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
  Codec _codec = Codec.aacMP4;

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
      var audioUrl;
      var imageUrl;
      var videoUrl;
      var titleLink;
      switch (status) {
        case AttachmentStatus.image:
          imageUrl = file.path;
          chatActionStatus = ChatActionStatus.sendingImage;
          break;
        case AttachmentStatus.video:
          videoUrl = file.path;
          chatActionStatus = ChatActionStatus.sendingVideo;
          break;
        case AttachmentStatus.file:
          titleLink = file.path;
          chatActionStatus = ChatActionStatus.sendingFile;
          break;
        default:
          imageUrl = file.path;
          chatActionStatus = ChatActionStatus.sendingImage;
          break;
      }
      final fileSize = await file.length();
      var fileFormat;
      var title = file.path.split('/').last;
      var type;
      final messageDto = getMessageDto();
      final newMessage = messageDto.copyWith(attachmentsRM: [
        AttachmentDto(
            id: DateTime.now().hashCode,
            audioSize: fileSize,
            fileSize: fileSize,
            imageSize: fileSize,
            audioUrl: audioUrl,
            fileDescription: '',
            fileFormat: fileFormat,
            imageUrl: imageUrl,
            title: title,
            titleLink: titleLink,
            type: type,
            videoUrl: videoUrl)
      ]);
      emit(state.mapOrNull((value) => value.copyWith(
              chatActionStatus: chatActionStatus, messageEntity: newMessage)) ??
          state);
    }
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

  Future initRecorder() async {
    await _mPlayer.closeAudioSession();
    await openTheRecorder();
    await _mPlayer.openAudioSession(mode: SessionMode.modeSpokenAudio);
    await _mPlayer.setSubscriptionDuration(Duration(milliseconds: 10));
    await _mRecorder.setSubscriptionDuration(Duration(milliseconds: 10));
  }

  Future<void> openTheRecorder() async {
    final isGranted = await _localService.handleRecorderPermission();
    if (isGranted) {
      await _mRecorder.openAudioSession(mode: SessionMode.modeSpokenAudio);
      if (!await _mRecorder.isEncoderSupported(_codec) && kIsWeb) {
        _codec = Codec.opusWebM;
        if (!await _mRecorder.isEncoderSupported(_codec) && kIsWeb) {
          return;
        }
      }
    } else {
      await openTheRecorder();
    }
  }

  Future<File> _getRecordFile() async {
    final dir = await _localService.getDirectory();
    final File recordFile = File('${dir?.path}/sound${ext[_codec.index]}');
    if (!recordFile.existsSync()) {
      recordFile.createSync(recursive: true);
    }
    return recordFile;
  }

  Future record() async {
    await initRecorder();
    final _recordFile = await _getRecordFile();

    try {
      await _mRecorder.startRecorder(
        toFile: _recordFile.path,
        codec: _codec,
        audioSource: AudioSource.microphone,
      );
      log('ChatBloc: ${_mRecorder.hashCode} -- ${_mRecorder.isRecording}');
      _mRecorder.onProgress?.listen((event) {
        emit(state.mapOrNull((value) => value.copyWith(
                chatActionStatus: ChatActionStatus.recordAudio,
                recordProgressTimer:
                    '${(event.duration.inMinutes % 60).toString().padLeft(2, '0')}:${(event.duration.inSeconds % 60).toString().padLeft(2, '0')}')) ??
            state);
      });
    } catch (e) {
      log('_onRecording: error: $e');
    }
  }

  Future playbackRecord() async {
    try {
      await _mRecorder.stopRecorder();
      final _recordFile = await _getRecordFile();
      await _mPlayer.setVolume(1);
      await _mPlayer.startPlayer(
          fromURI: _recordFile.path,
          codec: _codec,
          whenFinished: () async {
            await _mPlayer.stopPlayer();
          });
    } catch (e) {
      log('_onPlaybackRecord: error ${e}');
    }
  }

  Future closeRecorder() async {
    try {
      await _mPlayer.stopPlayer();
      await _mPlayer.closeAudioSession();
      await _mRecorder.stopRecorder();
      await _mRecorder.closeAudioSession();
      emit(state.mapOrNull((value) =>
              value.copyWith(chatActionStatus: ChatActionStatus.init)) ??
          state);
    } catch (e) {
      log('close: error $e');
    }
  }

  Future<MessageEntity> sendMessageToServer() async {
    final textEditingController =
        state.mapOrNull((value) => value.textEditingController);
    final currentMessage = getMessageDto().copyWith(
        msg: textEditingController?.text.isNotEmpty == true
            ? textEditingController!.text
            : null);
    log('sendMessageToServer: ${currentMessage.toJson()} -- ${currentMessage.attachmentsRM?.map((e) => e.toJson()).toList()}');
    final message = await _chatService.sendMessage(
        messageData: state.mapOrNull((value) => currentMessage)!);
    closeSend();
    textEditingController?.clear();
    return message;
  }

  void send({String? description}) {
    final currentMessage = getMessageDto();
    emit(state.mapOrNull((value) => value.copyWith(
            messageEntity: currentMessage.copyWith(
                attachmentsRM: currentMessage.attachmentsRM
                    ?.map(
                      (e) => e.copyWith(fileDescription: description),
                    )
                    .toList()),
            chatActionStatus: ChatActionStatus.send)) ??
        state);
  }

  void closeSend() {
    final chatActionStatus = state.mapOrNull((value) => value.chatActionStatus);
    final attachmentStatus = state.mapOrNull((value) => value.messageEntity?.attachmentStatus);
    if (chatActionStatus != ChatActionStatus.close) {
      switch (attachmentStatus) {
        case AttachmentStatus.file:
        case AttachmentStatus.video:
        case AttachmentStatus.image:
          emit(state.mapOrNull((value) => value.copyWith(
            chatActionStatus: ChatActionStatus.close,
          )) ??
              state);
          break;
        default:
          emit(state.mapOrNull((value) => value.copyWith(
            chatActionStatus: ChatActionStatus.init,
          )) ??
              state);
          break;
      }
    }
  }
}
