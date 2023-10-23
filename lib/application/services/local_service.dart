import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_application/data/dtos/authentication_dto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../initialize_dependencies.dart';

class LocalService {
  final String keyAuth = 'key_auth';

  final _sharedPref = sl.get<SharedPreferences>();

  bool isAuthorized() {
    return _sharedPref.containsKey(keyAuth);
  }

  Future saveAuth({required AuthenticationDto? auth}) async {
    if (auth != null) {
      await _sharedPref.setString(keyAuth, jsonEncode(auth.toJson()));
    } else {
      await _sharedPref.clear();
    }
  }

  AuthenticationDto? getAuthenticationDto() {
    if (_sharedPref.containsKey(keyAuth)) {
      final authData = jsonDecode(_sharedPref.getString(keyAuth) ?? '');
      return AuthenticationDto.fromJson(authData);
    } else {
      return null;
    }
  }

  Future<bool> requestPermission(Permission permission) async {
    final permissionStatus = await permission.status;
    if (!permissionStatus.isGranted) {
      await permission.request();
      return false;
    } else {
      return true;
    }
  }

  Future<bool> handleStoragePermission() async {
    if (Platform.isAndroid) {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      if (deviceInfo.version.sdkInt > 32) {
        return await requestPermission(Permission.manageExternalStorage);
      } else {
        return await requestPermission(Permission.storage);
      }
    } else {
      return await requestPermission(Permission.storage);
    }
  }

  Future<Directory?> getDirectory() async {
    return Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
  }
}
