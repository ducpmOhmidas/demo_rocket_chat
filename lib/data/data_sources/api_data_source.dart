import 'package:dio/dio.dart';
import 'package:flutter_application/data/dtos/profile_dto.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/authentication_entity.dart';
import '../../domain/entities/profile_entity.dart';
import '../dtos/authentication_dto.dart';

class ApiDataSource {
  final Dio _dio = GetIt.I.get();

  Future<AuthenticationEntity> login(String userName, String passWord) async {
    final data = {
      'user': userName,
      'password': passWord,
    };
    final response = await _dio.post('/login', data: data);
    if (response.statusCode == 200) {
      return AuthenticationDto.fromJson(response.data['data']);
    } else {
      throw response.statusMessage ?? '';
    }
  }

  Future logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  Future<ProfileEntity> profile({required String userId}) async {
    final queryParameters = {
      'userId': userId,
    };
    final response =
        await _dio.get('/users.info', queryParameters: queryParameters);
    if (response.statusCode == 200) {
      return ProfileDto.fromJson(response.data['user']);
    } else {
      throw response.statusMessage ?? '';
    }
  }
}
