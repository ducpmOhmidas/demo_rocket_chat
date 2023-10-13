import 'package:flutter_application/data/data_sources/mock_data_source.dart';
import 'package:flutter_application/domain/entities/authentication_entity.dart';
import 'package:flutter_application/domain/entities/profile_entity.dart';
import 'package:flutter_application/domain/repositories/auth/auth_mock_repository.dart';

class AuthMockRepositoryImpl implements AuthMockRepository {
  MockDataSource mockDataSource = MockDataSource();

  @override
  Future<String> defaultData() {
    return mockDataSource.defaultData();
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
    return mockDataSource.profile();
  }
}
