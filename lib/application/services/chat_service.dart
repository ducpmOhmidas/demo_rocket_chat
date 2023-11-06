import 'dart:developer';
import 'dart:io';

import 'package:flutter_application/domain/repositories/chat/chat_api_repository.dart';
import 'package:flutter_application/domain/repositories/chat/chat_local_repository.dart';
import 'package:flutter_application/presentation/blocs/message/message_state.dart';

import '../../domain/entities/message_entity.dart';
import '../../initialize_dependencies.dart';
import 'local_service.dart';

class ChatService {
  ChatService(
    this.baseImageUrl, {
    required this.chatApiRepository,
    required this.chatLocalRepository,
  });

  final ChatApiRepository chatApiRepository;
  final ChatLocalRepository chatLocalRepository;
  final String baseImageUrl;

  final _localService = sl.get<LocalService>();

  Future<File> getMedia(
      {required String url, required AttachmentStatus status}) async {
    final dir = await _localService.getDirectory();
    final String fileType;
    switch (status) {
      case AttachmentStatus.video:
        fileType = 'mp4';
        break;
      default:
        fileType = _fileType(url: url);
        break;
    }
    //	https://chat.ohmidasvn.dev/file-upload/6537246e955bcdac5fa2622f/2023-10-24T01:56:54.068Z.jpg
    final localPath = '${dir!.path}/${_fileName(url: url)}.$fileType';
    log('getMedia: $localPath -- $baseImageUrl$url');
    final fileData = chatLocalRepository.getMediaCache(localPath: localPath);
    if (fileData.item2) {
      return fileData.item1;
    } else {
      return chatApiRepository.getMediaNetWork(
          url: '$baseImageUrl$url', localPath: localPath);
    }
  }

  String _fileName({required String url}) {
    return url.split('/').last.split('.').first;
  }

  String _fileType({required String url}) {
    return url.split('.').last;
  }

  Future<MessageEntity> sendMessage(
      {required MessageEntity messageData, bool isEdit = false}) async {
    if (isEdit) {
      return chatApiRepository.editMessage(messageData);
    } else {
      switch (messageData.attachmentStatus) {
        case AttachmentStatus.file:
        case AttachmentStatus.image:
        case AttachmentStatus.video:
        case AttachmentStatus.audio:
          return chatApiRepository.uploadFile(messageData);
        default:
          return chatApiRepository.sendMessage(messageData);
      }
    }
  }

  Future<MessageEntity> handleAction(
      {required MessageEntity messageData,
      required MessageActionStatus status,
      String? description}) async {
    try {
      switch (status) {
        case MessageActionStatus.copy:
        case MessageActionStatus.share:
        case MessageActionStatus.edit:
        case MessageActionStatus.report:
          await chatApiRepository.reportMessage(
              messageId: messageData.id, description: description ?? '');
          return messageData;
        case MessageActionStatus.delete:
          return chatApiRepository.deleteMessage(messageData);
        default:
          return messageData;
      }
    } catch (e) {
      throw e;
    }
  }
}
