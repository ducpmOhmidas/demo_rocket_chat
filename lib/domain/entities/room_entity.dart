import 'package:flutter_application/domain/entities/message_entity.dart';

abstract class RoomEntity {
  String get id;

  String? get name;

  String? get updatedAt;

  int? totalMsgs;
  bool? isDefault;
  bool? sysMes;

  MessageEntity? get lastMsg;

  String? type;
}
