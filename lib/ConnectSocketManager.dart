import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_application/application/services/local_service.dart';
import 'package:flutter_application/data/dtos/message_dto.dart';
import 'package:flutter_application/domain/entities/message_entity.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ConnectSocketManager {
  LocalService localService = LocalService();

  late final WebSocketChannel channel;
  final String _rocketChatServer;
  final streamController = StreamController.broadcast();

  bool connected = false;

  subscribeRoomMessages({required String roomId}) {
    channel.sink.add(jsonEncode({
      "msg": "sub",
      "id": "89494",
      "name": "stream-room-messages",
      "params": [roomId, false]
    }));
  }

  watchConnect() {
    streamController.stream.listen((event) {
      log('WebSocketChannel: $event');
      final data = jsonDecode(event);
      if (data['msg'] == 'ping') {
        channel.sink.add(jsonEncode({"msg": "pong"}));
      }
    });
  }

  Stream<List<MessageEntity>> watchRoomMessages(
      {required String roomId}) async* {
    subscribeRoomMessages(roomId: roomId);
    yield* streamController.stream.where((event) {
      final data = jsonDecode(event);
      return data['msg'] == 'changed' &&
          data['collection'] == 'stream-room-messages';
    }).map((event) {
      final data = jsonDecode(event);
      return (data["fields"]["args"] as List<dynamic>)
          .map((e) => MessageDto.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  ConnectSocketManager({required String rocketChatServer})
      : _rocketChatServer = rocketChatServer {
    final wsUrl = Uri.parse(rocketChatServer);
    channel = WebSocketChannel.connect(wsUrl);
    if (localService.isAuthorized()) {
      final auth = localService.getAuthenticationDto();
      streamController.addStream(channel.stream);
      watchConnect();
      channel.sink.add(jsonEncode({
        "msg": "connect",
        "version": "1",
        "support": ["1"]
      }));
      channel.sink.add(jsonEncode({
        "msg": "method",
        "method": "login",
        "id": "42",
        "params": [
          {"resume": auth?.accessToken}
        ]
      }));
    }
  }

  void reconnect() {}

  void onLogInSuccess(String token) {}

  void logout() {}

  void disconnect() {}

  void on(String event, Function(dynamic) valueChanged) {}

  void off(String event) {}
}
