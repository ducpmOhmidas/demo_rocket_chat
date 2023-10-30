import 'dart:io';

import 'package:flutter_application/data/data_sources/api_data_source.dart';
import 'package:flutter_application/domain/entities/message_entity.dart';
import 'package:flutter_application/domain/repositories/chat/chat_api_repository.dart';

class ChatApiRepositoryImpl implements ChatApiRepository {
  final _apiDataSource = ApiDataSource();
  @override
  Future<File> getMediaNetWork(
      {required String url, required String localPath}) {
    return _apiDataSource.downloadFileFromUrl(url: url, localPath: localPath);
  }

  @override
  Future<MessageEntity> sendMessage(MessageEntity messageEntity) {
    return _apiDataSource.sendMessage(messageEntity);
  }

  @override
  Future<MessageEntity> uploadFile(MessageEntity messageEntity) {
    return _apiDataSource.uploadFile(messageEntity);
  }

  @override
  Future<MessageEntity> deleteMessage(MessageEntity messageEntity) {
    return _apiDataSource.deleteMessage(messageEntity);
  }

  @override
  Future<MessageEntity> editMessage(MessageEntity messageEntity) {
    return _apiDataSource.editMessage(messageEntity);
  }
}
