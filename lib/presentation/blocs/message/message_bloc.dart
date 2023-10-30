import 'package:chewie/chewie.dart';
import 'package:flutter_application/application/services/chat_service.dart';
import 'package:flutter_application/domain/entities/message_entity.dart';
import 'package:flutter_application/presentation/blocs/message/message_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:open_file/open_file.dart';
import 'package:video_player/video_player.dart';

class MessageBloc extends Cubit<MessageState> {
  MessageBloc({required MessageEntity data, required ChatService chatService})
      : _chatService = chatService,
        super(MessageStateData(data,
            mediaStatus: MediaStatus.init,
            messageActionStatus: MessageActionStatus.noAction)) {
    init();
  }

  final ChatService _chatService;

  @override
  Future<void> close() {
    state.mapOrNull((value) => value.videoController)?.dispose();
    state.mapOrNull((value) => value.chewieController)?.dispose();
    state.mapOrNull((value) => value.audioController)?.stop();
    state.mapOrNull((value) => value.audioController)?.dispose();
    return super.close();
  }

  Future init() async {
    final data = (state.mapOrNull((value) => value.data));
    switch (data?.attachmentStatus) {
      case AttachmentStatus.file:
        break;
      case AttachmentStatus.image:
        emit(state.maybeMap(
            (value) => value.copyWith(mediaStatus: MediaStatus.loading),
            orElse: () => state));
        final mediaFile = await _chatService.getMedia(
            url: data!.attachments!.first.imageUrl!,
            status: AttachmentStatus.image);
        emit(state.maybeMap(
            (value) => value.copyWith(
                mediaFile: mediaFile, mediaStatus: MediaStatus.data),
            orElse: () => state));
        break;
      case AttachmentStatus.video:
        break;
      case AttachmentStatus.audio:
        break;
      default:
        break;
    }
  }

  updateMessage({required MessageEntity messageEntity}) {
    emit(state.maybeMap(
            (value) => value.copyWith(data: messageEntity),
        orElse: () => state));
  }

  Future downloadVideo() async {
    final data = (state.mapOrNull((value) => value.data));
    emit(state.maybeMap(
        (value) => value.copyWith(mediaStatus: MediaStatus.loading),
        orElse: () => state));
    final mediaFile = await _chatService.getMedia(
        url: data!.attachments!.first.videoUrl!,
        status: AttachmentStatus.video);
    final controller = VideoPlayerController.file(mediaFile);
    final chewieController = ChewieController(
      videoPlayerController: controller,
      autoPlay: true,
      // looping: true,
    );
    emit(state.maybeMap(
        (value) => value.copyWith(
            mediaFile: mediaFile,
            videoController: controller,
            chewieController: chewieController,
            mediaStatus: MediaStatus.data),
        orElse: () => state));
  }

  Future downloadAudio() async {
    final data = (state.mapOrNull((value) => value.data));
    emit(state.maybeMap(
        (value) => value.copyWith(mediaStatus: MediaStatus.loading),
        orElse: () => state));
    final mediaFile = await _chatService.getMedia(
        url: data!.attachments!.first.audioUrl!,
        status: AttachmentStatus.audio);
    final controller = AudioPlayer(handleAudioSessionActivation: false);
    await controller.setAudioSource(AudioSource.file(mediaFile.path));
    emit(state.maybeMap(
        (value) => value.copyWith(
            mediaFile: mediaFile,
            audioController: controller,
            mediaStatus: MediaStatus.data),
        orElse: () => state));
    await controller.play();
  }

  Future openFile() async {
    final data = (state.mapOrNull((value) => value.data));
    final mediaFile = await _chatService.getMedia(
        url: data!.attachments!.first.titleLink!,
        status: AttachmentStatus.file);
    await OpenFile.open(mediaFile.path);
  }

  //region handle action

  void initAction() {
    final messageActionStatus = state.mapOrNull((value) => value.messageActionStatus);
    if (messageActionStatus != MessageActionStatus.noAction) {
      emit(state.mapOrNull((value) => value.copyWith(
          messageActionStatus: MessageActionStatus.noAction)) ??
          state);
    }
  }

  void showAction() {
    emit(state.mapOrNull((value) => value.copyWith(
            messageActionStatus: MessageActionStatus.showAction)) ??
        state);
  }

  void copy() {}

  Future share() async {}

  Future edit() async {}

  Future delete() async {
    final messageData = state.mapOrNull((value) => value.data);
    if (messageData != null) {
      emit(state.mapOrNull((value) => value.copyWith(
              messageActionStatus: MessageActionStatus.delete)) ??
          state);
      _chatService
          .handleAction(
              messageData: messageData, status: MessageActionStatus.delete)
          .then((value) => emit(state.mapOrNull((value) => value.copyWith(
                  messageActionStatus: MessageActionStatus.completedDelete)) ??
              state))
          .onError((error, stackTrace) => emit(state.mapOrNull(
                (value) => value.copyWith(
                    messageActionStatus: MessageActionStatus.error,
                    errorMsg: error.toString()),
              ) ??
              state));
    }
  }

  void closeAction() {
    final messageActionStatus = state.mapOrNull((value) => value.messageActionStatus);
    if (messageActionStatus != MessageActionStatus.close) {
      emit(state.mapOrNull((value) => value.copyWith(
          messageActionStatus: MessageActionStatus.close)) ??
          state);
    }
  }

  //endregion
}
