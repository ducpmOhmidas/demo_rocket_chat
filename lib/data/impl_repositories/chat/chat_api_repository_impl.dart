import 'dart:io';

import 'package:flutter_application/data/data_sources/api_data_source.dart';
import 'package:flutter_application/domain/repositories/chat/chat_api_repository.dart';

class ChatApiRepositoryImpl implements ChatApiRepository {
  final _apiDataSource = ApiDataSource();
  @override
  Future<File> getMediaNetWork(
      {required String url, required String localPath}) {
    return _apiDataSource.downloadFileFromUrl(url: url, localPath: localPath);
  }
}
