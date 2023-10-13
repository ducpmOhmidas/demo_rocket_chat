import 'package:flutter_application/data/data_sources/local_data_source.dart';
import 'package:flutter_application/domain/entities/authentication_entity.dart';
import 'package:flutter_application/domain/entities/profile_entity.dart';
import 'package:flutter_application/domain/repositories/auth/auth_local_reposirory.dart';

class AuthLocalRepositoryImpl implements AuthLocalRepository {
  LocalDataSource localDataSource = LocalDataSource();

  @override
  Future<String> defaultData() {
    return localDataSource.defaultData();
  }

  @override
  Future<AuthenticationEntity> login(String userName, String passWord) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<ProfileEntity> profile() {
    // TODO: implement profile
    throw UnimplementedError();
  }
}
