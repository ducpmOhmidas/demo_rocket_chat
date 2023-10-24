import 'dart:developer';
import 'dart:io';

import 'package:flutter_application/domain/repositories/chat/chat_api_repository.dart';
import 'package:flutter_application/domain/repositories/chat/chat_local_repository.dart';

import '../../initialize_dependencies.dart';
import 'local_service.dart';

class ChatService {
  ChatService(this.baseImageUrl, {required this.chatApiRepository, required this.chatLocalRepository, });

  final ChatApiRepository chatApiRepository;
  final ChatLocalRepository chatLocalRepository;
  final String baseImageUrl;

  final _localService = sl.get<LocalService>();

  Future<File> getMedia({required String url}) async {
    final dir = await _localService.getDirectory();
    //	https://chat.ohmidasvn.dev/file-upload/6537246e955bcdac5fa2622f/2023-10-24T01:56:54.068Z.jpg
    final localPath = '${dir!.path}/${_fileName(url: url)}';
    log('getMedia: $localPath');
    final fileData = chatLocalRepository.getMediaCache(localPath: localPath);
    if (fileData.item2) {
      return fileData.item1;
    } else {
      return chatApiRepository.getMediaNetWork(url: url, localPath: localPath);
    }
  }

  String _fileName({required String url}) {
    return url.split('/').last;
  }
}