import 'dart:io';

import 'package:tuple/tuple.dart';

abstract class UserLocalRepository {
  Tuple2<File, bool> getAvatarCache({required String localPath});
}