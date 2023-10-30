import 'dart:developer';
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
import 'package:http_parser/src/media_type.dart';

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
  Future<File> downloadFileFromUrl(
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
        return File(localPath);
      } else {
        throw response.statusMessage ?? '';
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
      {required String roomId,
      required int offset,
      required int total,
      String type = 'c'}) async {
    final queryParameters = {
      'roomId': roomId,
      'offset': offset,
      'count': total,
    };
    final String endpoint;
    switch (type) {
      case 'd':
        endpoint = '/im.messages';
        break;
      case 'p':
        endpoint = '/groups.history';
        break;
      default:
        endpoint = '/channels.messages';
        break;
    }
    final response = await _dio.get(endpoint, queryParameters: queryParameters);
    if (response.statusCode == 200) {
      return (response.data['messages'] as List<dynamic>?)
              ?.map((e) => MessageDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
    } else {
      throw response.statusMessage ?? '';
    }
  }

  Future<MessageEntity> sendMessage(MessageEntity messageEntity) async {
    final data = {
      "message": {"rid": messageEntity.rid, "msg": messageEntity.msg},
      "previewUrls": []
    };
    final response = await _dio.post('/chat.sendMessage', data: data);
    if (response.statusCode == 200) {
      return MessageDto.fromJson(response.data['message']);
    } else {
      throw response.statusMessage ?? '';
    }
  }

  Future<MessageEntity> uploadFile(MessageEntity messageEntity) async {
    final String filePath;
    final attachment = messageEntity.attachments!.first;
    final type;
    final subType;
    switch (messageEntity.attachmentStatus) {
      case AttachmentStatus.file:
        filePath = attachment.titleLink!;
        type = 'application';
        subType = 'octet-stream';
        break;
      case AttachmentStatus.image:
        filePath = attachment.imageUrl!;
        type = 'image';
        subType = filePath.split('.').last;
        break;
      case AttachmentStatus.video:
        filePath = attachment.videoUrl!;
        type = 'video';
        subType = filePath.split('.').last;
        break;
      case AttachmentStatus.audio:
        filePath = attachment.audioUrl!;
        type = 'audio';
        subType = filePath.split('.').last;
        break;
      default:
        filePath = attachment.titleLink!;
        type = 'application';
        subType = 'octet-stream';
        break;
    }
    final file = await MultipartFile.fromFile(filePath,
        // filename: filePath.split('/').last.split('.').first,
        contentType: MediaType(type, subType));
    final formData = FormData.fromMap({
      "file": file,
      'msg': messageEntity.msg,
      'description': attachment.fileDescription,
    });
    log('uploadFile: ${file.contentType?.type} -- ${file.contentType?.subtype} -- ${file.filename} -- ${file.headers} -- ${file.contentType?.parameters} -- ${formData.fields}');
    final response = await _dio.post(
      '/rooms.upload/${messageEntity.rid}',
      data: formData,
    );
    if (response.statusCode == 200) {
      return MessageDto.fromJson(
        response.data['message'],
      );
    } else {
      throw response.statusMessage ?? '';
    }
  }

  Future<MessageEntity> deleteMessage(MessageEntity messageEntity) async {
    final data = {
      "roomId": messageEntity.rid,
      "msgId": messageEntity.id,
      "asUser": true
    };
    final response = await _dio.post('/chat.delete', data: data);
    if (response.statusCode == 200) {
      return MessageDto.fromJson(response.data['message']);
    } else {
      throw response.statusMessage ?? '';
    }
  }

  Future<MessageEntity> editMessage(MessageEntity messageEntity) async {
    final data = {
      "roomId": messageEntity.rid,
      "msgId": messageEntity.id,
      "text": messageEntity.msg,
      "previewUrls": []
    };
    final response = await _dio.post('/chat.update', data: data);
    if (response.statusCode == 200) {
      log('editMessage: ${response.data['message']}');
      return MessageDto.fromJson(response.data['message']);
    } else {
      throw response.statusMessage ?? '';
    }
  }

  //endregion
}
