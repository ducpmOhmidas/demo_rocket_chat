import 'package:flutter_application/data/dtos/message_dto.dart';
import 'package:flutter_application/domain/entities/room_entity.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/message_entity.dart';

part 'room_dto.g.dart';

@JsonSerializable()
class RoomDto implements RoomEntity {
  factory RoomDto.fromJson(Map<String, dynamic> json) =>
      _$RoomDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RoomDtoToJson(this);

  RoomDto(this.isDefault, this.sysMes, this.totalMsgs, this.id,
      this.lastMessage, this.nameRM, this.updatedAtRM, this.usernames);

  @override
  @JsonKey(name: 'default')
  bool? isDefault;

  @override
  bool? sysMes;

  @override
  @JsonKey(name: 'msgs')
  int? totalMsgs;

  @override
  @JsonKey(name: '_id')
  String id;

  Map<String, dynamic>? lastMessage;

  @override
  MessageEntity? get lastMsg {
    if (lastMessage != null) {
      return MessageDto.fromJson(lastMessage!);
    } else {
      return null;
    }
  }

  @JsonKey(name: 'name')
  String? nameRM;

  @override
  String? get name {
    if (type == 'd') {
      return usernames != null && usernames!.isNotEmpty ? usernames!.last : '';
    } else {
      return nameRM;
    }
  }

  final formatter = DateFormat('dd/MM/yyyy');

  @JsonKey(name: '_updatedAt')
  String? updatedAtRM;

  @override
  String get updatedAt {
    return updatedAtRM != null
        ? formatter.format(DateTime.tryParse(updatedAtRM!) ?? DateTime.now())
        : '';
  }

  @override
  @JsonKey(name: 't')
  String? type;

  List<String>? usernames;
}
