import 'dart:developer';
import 'dart:io';

import 'package:flutter_application/application/services/local_service.dart';
import 'package:flutter_application/domain/entities/profile_entity.dart';
import 'package:flutter_application/domain/repositories/user/user_api_repository.dart';
import 'package:flutter_application/domain/repositories/user/user_local_repository.dart';

class UserService {
  UserService(this.baseImageUrl,
      {required this.userApiRepository, required this.userLocalRepository});
  final String baseImageUrl;
  final UserApiRepository userApiRepository;
  final UserLocalRepository userLocalRepository;

  final _localService = LocalService();

  Future<String> getAvatar({required ProfileEntity profileEntity}) async {
    final dir = await _localService.getDirectory();
    final localPath = '${dir!.path}/${profileEntity.id}.svg';
    final fileData = userLocalRepository.getAvatarCache(localPath: localPath);
    log('getAvatar: $baseImageUrl/avatar/${profileEntity.userName}');
    // if (fileData.item2) {
    //   return fileData.item1;
    // } else {
    return userApiRepository.getAvatarNetwork(
        url: '$baseImageUrl/avatar/${profileEntity.userName}',
        localPath: localPath);
    // }
  }

  String _fileName({required String url}) {
    return url.split('/').last.split('.').first;
  }

  String _fileType({required String url}) {
    return url.split('.').last;
  }
}
