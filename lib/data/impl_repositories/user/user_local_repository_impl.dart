import 'dart:developer';
import 'dart:io';

import 'package:tuple/tuple.dart';

import '../../../domain/repositories/user/user_local_repository.dart';

class UserLocalRepositoryImpl implements UserLocalRepository {
  @override
  Tuple2<File, bool> getAvatarCache({required String localPath}) {
    log('getAvatarCache: $localPath');
    final file = File(localPath);
    if (!file.existsSync()) {
      file.createSync();
      return Tuple2(file, false);
    }
    return Tuple2(file, true);
  }

}