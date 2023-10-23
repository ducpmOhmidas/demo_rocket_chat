import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_application/data/dtos/message_dto.dart';
import 'package:flutter_application/data/dtos/profile_dto.dart';
import 'package:flutter_application/data/dtos/room_dto.dart';
import 'package:flutter_application/domain/entities/message_entity.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/authentication_entity.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/room_entity.dart';
import '../../initialize_dependencies.dart';
import '../dtos/authentication_dto.dart';

class ApiDataSource {
  final Dio _dio = sl.get();

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

  //region storage
  @override
  Future<String> downloadFileFromUrl(
      {required String url, required String localPath}) async {
    try {
      final response = await _dio.download(url, localPath,
          options: Options(
            headers: {
              'content-encoding': gzip,
            },
            responseType: ResponseType.bytes,
            followRedirects: false,
          ));
      if (response.statusCode == 200) {
        return localPath;
      } else {
        return response.statusMessage ?? '';
      }
    } catch (e) {
      rethrow;
    }
  }
  //endregion

  //region channel
  Future<List<RoomEntity>> fetchRooms() async {
    final response = await _dio.get('/rooms.get');
    if (response.statusCode == 200) {
      return (response.data['update'] as List<dynamic>?)
              ?.map((e) => RoomDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
    } else {
      throw response.statusMessage ?? '';
    }
  }
  //endregion

  //region chat
  Future<List<MessageEntity>> fetchMessages(
      {required String roomId, required int offset, required int total}) async {
    final queryParameters = {
      'roomId': roomId,
      'offset': offset,
      'count': total,
    };
    final response =
        await _dio.get('/channels.messages', queryParameters: queryParameters);
    if (response.statusCode == 200) {
      return (response.data['messages'] as List<dynamic>?)
              ?.map((e) => MessageDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
    } else {
      throw response.statusMessage ?? '';
    }
  }
  //endregion

}
