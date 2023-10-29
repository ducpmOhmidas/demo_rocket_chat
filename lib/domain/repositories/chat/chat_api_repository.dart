import 'dart:io';

import '../../entities/message_entity.dart';

abstract class ChatApiRepository {
  Future<File> getMediaNetWork(
      {required String url, required String localPath});

  Future<MessageEntity> sendMessage(MessageEntity messageEntity);

  Future<MessageEntity> uploadFile(MessageEntity messageEntity);
}
