import 'package:flutter_application/domain/entities/message_entity.dart';

abstract class ChatApiRepository {
  Future<String> getMediaNetWork(
      {required String url, required String localPath});
}
