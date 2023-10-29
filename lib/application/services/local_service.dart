import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_application/data/dtos/authentication_dto.dart';
import 'package:flutter_application/domain/entities/message_entity.dart';
import 'package:image_picker/image_picker.dart';
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

  Future<bool> handleRecorderPermission() async {
    return await requestPermission(Permission.microphone);
  }

  Future<Directory?> getDirectory() async {
    return Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getTemporaryDirectory();
  }

  Future<XFile?> onPickFile({
    ImageSource source = ImageSource.camera,
    AttachmentStatus status = AttachmentStatus.image,
  }) async {
    final ImagePicker _picker = ImagePicker();
    switch (status) {
      case AttachmentStatus.image:
        final XFile? pickedFile = await _picker.pickImage(
          source: source,
          imageQuality: 100,
        );
        return pickedFile;
      case AttachmentStatus.video:
        final XFile? file = await _picker.pickVideo(
            source: source, maxDuration: const Duration(seconds: 10));
        return file;
      case AttachmentStatus.file:
        FilePickerResult? result = await FilePicker.platform.pickFiles();

        // final XFile? file = await _picker.pickVideo(
        //     source: source, maxDuration: const Duration(seconds: 10));
        if (result != null) {
          final file = XFile(result.files.single.path!);
          return file;
        } else {
          return null;
        }
      default:
        final XFile? media = await _picker.pickMedia(
          imageQuality: 100,
        );
        return media;
    }
  }
}
