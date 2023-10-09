import 'package:flutter_application/data/repositories/auth/auth_api_repository.dart';
import 'package:flutter_application/domain/models/authentication_model.dart';
import 'package:flutter_application/domain/models/profile_model.dart';

class AuthApiDataSource extends AuthApiRepository {
  @override
  Future<AuthenticationModel> login(String userName, String passWord) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<ProfileModel> profile() {
    // TODO: implement profile
    throw UnimplementedError();
  }
}
