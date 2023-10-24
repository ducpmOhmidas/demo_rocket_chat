import 'package:flutter_application/application/services/chat_service.dart';
import 'package:flutter_application/domain/entities/message_entity.dart';
import 'package:flutter_application/presentation/blocs/message/message_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageBloc extends Cubit<MessageState> {
  MessageBloc({required MessageEntity data, required ChatService chatService})
      : _chatService = chatService,
        super(MessageStateData(data,
            mediaLoading: true));

  final ChatService _chatService;

  Future init() async {
    final data = (state.mapOrNull((value) => value.data));
    switch (data?.attachmentStatus) {
      case AttachmentStatus.file:
        break;
      case AttachmentStatus.image:
        final mediaFile = await _chatService.getMedia(
            url: data!.attachments!.first.imageUrl!);
        emit(state.maybeMap((value) => value.copyWith(mediaFile: mediaFile),
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

  Future downloadVideo() async {
    final data = (state.mapOrNull((value) => value.data));
    emit(MessageState.loading());
    final mediaFile = await _chatService.getMedia(
        url: data!.attachments!.first.videoUrl!);
    emit(state.maybeMap((value) => value.copyWith(mediaFile: mediaFile),
        orElse: () => state));
  }
}
