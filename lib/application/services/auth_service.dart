import 'package:flutter_application/application/services/local_service.dart';
import 'package:flutter_application/domain/entities/authentication_entity.dart';
import 'package:flutter_application/domain/entities/profile_entity.dart';
import 'package:get_it/get_it.dart';

import '../../domain/repositories/auth/auth_api_repository.dart';
import '../../domain/repositories/auth/auth_local_reposirory.dart';
import '../../domain/repositories/auth/auth_mock_repository.dart';

class AuthService {
  AuthService(
    this.authMockRepository,
    this.authLocalRepository,
    this.authApiRepository,
  );

  final AuthMockRepository authMockRepository;
  final AuthLocalRepository authLocalRepository;
  final AuthApiRepository authApiRepository;

  final _localService = GetIt.instance.get<LocalService>();

  Future<AuthenticationEntity> login(String userName, String passWord) {
    return authApiRepository.login(userName, passWord);
  }

  Future logout() {
    return authMockRepository.logout();
  }

  Future<ProfileEntity> profile({required String userId}) {
    return authApiRepository.profile(userId: userId);
  }

  Future<String> defaultData() {
    if (_localService.isAuthorized()) {
      return authMockRepository.defaultData();
    } else {
      return authLocalRepository.defaultData();
    }
  }
}
