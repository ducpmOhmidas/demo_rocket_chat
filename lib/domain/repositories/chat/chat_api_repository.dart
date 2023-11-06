import 'dart:io';

import '../../entities/message_entity.dart';

abstract class ChatApiRepository {
  Future<File> getMediaNetWork(
      {required String url, required String localPath});

  Future<MessageEntity> sendMessage(MessageEntity messageEntity);

  Future<MessageEntity> uploadFile(MessageEntity messageEntity);

  Future<MessageEntity> deleteMessage(MessageEntity messageEntity);

  Future<MessageEntity> editMessage(MessageEntity messageEntity);

  Future<bool> reportMessage({required messageId, required String description});
}
