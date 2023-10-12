import 'package:flutter_application/data/dtos/authentication_dto.dart';
import 'package:flutter_application/data/dtos/profile_dto.dart';
import 'package:flutter_application/data/repositories/auth/auth_mock_repository.dart';
import 'package:flutter_application/domain/models/authentication_model.dart';
import 'package:flutter_application/domain/models/profile_model.dart';

class AuthMockDataSource extends AuthMockRepository {
  @override
  Future<AuthenticationModel> login(String userName, String passWord) async {
    return AuthenticationDto('accessToken', 'refreshToken');
  }

  @override
  Future logout() async {}

  @override
  Future<ProfileModel> profile() async {
    return ProfileDto('duc', 'email', 'id');
  }

  @override
  Future<String> defaultData() async {
    return 'Data Auth';
  }
}
