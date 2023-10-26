import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';

import '../../../domain/entities/message_entity.dart';
part 'message_state.freezed.dart';

enum MediaStatus {
  init,
  loading,
  data,
}

@freezed
abstract class MessageState with _$MessageState {
  const factory MessageState(MessageEntity data,
      {File? mediaFile,
      required MediaStatus mediaStatus,
      VideoPlayerController? videoController,
      ChewieController? chewieController,
      AudioPlayer? audioController}) = MessageStateData;
  const factory MessageState.loading() = MessageStateLoading;
  const factory MessageState.error(dynamic error) = MessageStateError;
}
