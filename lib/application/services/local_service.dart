import 'dart:convert';

import 'package:flutter_application/data/dtos/authentication_dto.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalService {
  final String keyAuth = 'key_auth';

  final _sharedPref = GetIt.instance.get<SharedPreferences>();

  bool isAuthorized() {
    return _sharedPref.containsKey(keyAuth);
  }

  Future saveAuth({required AuthenticationDto? auth}) async {
    if (auth != null) {
      await _sharedPref.setString(keyAuth, jsonEncode(auth.toJson()));
    } else {
      _sharedPref.clear();
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
}
