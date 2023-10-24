import 'dart:io';

import 'package:tuple/tuple.dart';

abstract class ChatLocalRepository {
  Tuple2<File, bool> getMediaCache({required String localPath});
}