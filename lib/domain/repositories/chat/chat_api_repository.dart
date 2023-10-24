import 'dart:io';

abstract class ChatApiRepository {
  Future<File> getMediaNetWork(
      {required String url, required String localPath});
}
