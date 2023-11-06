import 'dart:io';

import 'package:flutter_application/data/data_sources/api_data_source.dart';
import 'package:flutter_application/domain/repositories/user/user_api_repository.dart';

class UserApiRepositoryImpl implements UserApiRepository {
  final _apiDataSource = ApiDataSource();
  @override
  Future<String> getAvatarNetwork({required String url, required String localPath}) {
    return _apiDataSource.downloadAvatar(userId: '7rmTXLew4HTJe5YSc', savePath: localPath);
  }

}