import 'dart:io';

abstract class UserApiRepository {
  Future<String> getAvatarNetwork(
      {required String url, required String localPath});
}