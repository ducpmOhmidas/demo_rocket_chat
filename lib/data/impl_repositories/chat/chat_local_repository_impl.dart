import 'dart:io';

import 'package:flutter_application/domain/repositories/chat/chat_local_repository.dart';
import 'package:tuple/tuple.dart';

class ChatLocalRepositoryImpl implements ChatLocalRepository {
  @override
  Tuple2<File, bool> getMediaCache({required String localPath}) {
    final file = File(localPath);
    if (!file.existsSync()) {
      file.createSync();
      return Tuple2(file, false);
    }
    return Tuple2(file, true);
  }
}
