import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/ConnectSocketManager.dart';
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

import '../../../initialize_dependencies.dart';

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
            ChatActionStatus.init,
            ChatActionStatus.init,
            textFieldFocusNode: FocusNode())) {
    log('stream-room-messages init');
    final socketManageer = sl.get<ConnectSocketManager>();
    messageStreamSubscription =
        socketManageer.watchRoomMessages(roomId: roomEntity.id).listen((event) {
      for (var e in event) {
        realtimeAddMessage(messageEntity: e);
      }
    });
  }

  LocalService _localService;
  ChatService _chatService;
  RoomEntity _roomEntity;
  FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
  Codec _codec = Codec.aacMP4;
  late final StreamSubscription messageStreamSubscription;

  @override
  Future<void> close() {
    messageStreamSubscription.cancel();
    return super.close();
  }

  void init() {
    emit(state.mapOrNull((value) => value.copyWith(
              chatActionStatus: ChatActionStatus.init,
              messageEntity: null,
            )) ??
        state);
  }

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
            ?.map((e) => ProfileDto(e.name, e.id, e.userName))
            .toList(),
        msg: currentMessage?.msg,
        userInforRM: ProfileDto(
            currentMessage?.userInfor?.name,
            currentMessage?.userInfor?.id ?? '',
            currentMessage?.userInfor?.userName),
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

  //region record audio
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
    final messageDto = getMessageDto();

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
                    '${(event.duration.inMinutes % 60).toString().padLeft(2, '0')}:${(event.duration.inSeconds % 60).toString().padLeft(2, '0')}',
                messageEntity: messageDto.copyWith(
                  attachmentsRM: [
                    AttachmentDto(
                        id: DateTime.now().hashCode,
                        audioSize: null,
                        fileSize: null,
                        imageSize: null,
                        audioUrl: _recordFile.path,
                        fileDescription: '',
                        fileFormat: null,
                        imageUrl: null,
                        title: null,
                        titleLink: null,
                        type: null,
                        videoUrl: null)
                  ],
                ))) ??
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
      log('closeRecorder: ${state.mapOrNull((value) => value.messageEntity?.attachmentStatus)} -- ${state.mapOrNull((value) => value.messageEntity?.attachments?.first.audioUrl)}');
      init();
    } catch (e) {
      log('close: error $e');
    }
  }
  //endregion

  //region send message
  Future<MessageEntity> sendMessageToServer() async {
    final textEditingController =
        state.mapOrNull((value) => value.textEditingController);
    final currentMessage = getMessageDto().copyWith(
        msg: textEditingController?.text.isNotEmpty == true
            ? textEditingController!.text
            : null);
    log('sendMessageToServer: ${currentMessage.toJson()} -- ${currentMessage.attachmentsRM?.map((e) => e.toJson()).toList()}');
    final message = await _chatService.sendMessage(
        messageData: currentMessage,
        isEdit: state.mapOrNull((value) => value.chatActionStatus) ==
            ChatActionStatus.edited);
    state.mapOrNull((value) => value.chatActionStatus) ==
            ChatActionStatus.edited
        ? init()
        : closeSend();
    textEditingController?.clear();
    state.mapOrNull((value) => value.textFieldFocusNode)?.unfocus();
    return message;
  }

  Future send({String? description, bool updateLocal = false}) async {
    final currentMessage = getMessageDto();
    final chatActionStatus = state.mapOrNull((value) => value.chatActionStatus);
    if (chatActionStatus == ChatActionStatus.editing) {
      emit(state.mapOrNull((value) => value.copyWith(
              messageEntity: currentMessage,
              chatActionStatus: ChatActionStatus.edited)) ??
          state);
    } else {
      if (chatActionStatus == ChatActionStatus.recordAudio) {
        await closeRecorder();
      }
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
  }

  void closeSend() {
    final chatActionStatus = state.mapOrNull((value) => value.chatActionStatus);
    final attachmentStatus =
        state.mapOrNull((value) => value.messageEntity?.attachmentStatus);
    if (chatActionStatus != ChatActionStatus.close) {
      switch (attachmentStatus) {
        case AttachmentStatus.file:
        case AttachmentStatus.video:
        case AttachmentStatus.image:
          emit(state.mapOrNull((value) => value.copyWith(
                    chatActionStatus: ChatActionStatus.close,
                    messageEntity: null,
                  )) ??
              state);
          break;
        default:
          init();
          break;
      }
    }
  }
  //endregion

  //region update Local
  void realtimeAddMessage({required MessageEntity messageEntity}) {
    log('realtimeAddMessage: $messageEntity');
    // state.mapOrNull((value) => value.messageDataSource).
    emit(state.mapOrNull((value) => value.copyWith(
            realtimeChatActionStatus: messageEntity.isEdit
                ? ChatActionStatus.realtimeUpdate
                : ChatActionStatus.realtimeAdd,
            realtimeMessageEntity: messageEntity)) ??
        state);
    Future.delayed((Duration(milliseconds: 10)), () {
      emit(state.mapOrNull((value) => value.copyWith(
              realtimeChatActionStatus: ChatActionStatus.realtimeDone)) ??
          state);
    });
  }

  void realtimeUpdateMessage({required MessageEntity messageEntity}) {
    log('realtimeAddMessage: $messageEntity');
    emit(state.mapOrNull((value) => value.copyWith(
            chatActionStatus: ChatActionStatus.realtimeUpdate,
            realtimeMessageEntity: messageEntity)) ??
        state);
    Future.delayed((Duration(milliseconds: 10)), () {
      emit(state.mapOrNull((value) => value.copyWith(
              chatActionStatus: ChatActionStatus.realtimeDone)) ??
          state);
    });
  }
  //endregion

  void edit({required MessageEntity messageEntity}) {
    final msg = (messageEntity.attachmentStatus == AttachmentStatus.none)
        ? (messageEntity.msg ?? '')
        : messageEntity.attachments?.first.fileDescription ?? '';
    state.mapOrNull((value) => value.textEditingController)?.text = msg;
    state.mapOrNull((value) => value.textFieldFocusNode)?.requestFocus();
    emit(state.mapOrNull((value) => value.copyWith(
            chatActionStatus: ChatActionStatus.editing,
            messageEntity: messageEntity)) ??
        state);
  }

  void cancelEdit() {
    state.mapOrNull((value) => value.textFieldFocusNode)?.unfocus();
    state.mapOrNull((value) => value.textEditingController)?.clear();
    emit(state.mapOrNull((value) => value.copyWith(
            chatActionStatus: ChatActionStatus.init, messageEntity: null)) ??
        state);
  }
}
