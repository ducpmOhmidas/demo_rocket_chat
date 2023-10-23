// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomDto _$RoomDtoFromJson(Map<String, dynamic> json) => RoomDto(
      json['default'] as bool?,
      json['sysMes'] as bool?,
      json['msgs'] as int?,
      json['_id'] as String,
      json['lastMessage'] as Map<String, dynamic>?,
      json['name'] as String?,
      json['_updatedAt'] as String?,
      (json['usernames'] as List<dynamic>?)?.map((e) => e as String).toList(),
    )..type = json['t'] as String?;

Map<String, dynamic> _$RoomDtoToJson(RoomDto instance) => <String, dynamic>{
      'default': instance.isDefault,
      'sysMes': instance.sysMes,
      'msgs': instance.totalMsgs,
      '_id': instance.id,
      'lastMessage': instance.lastMessage,
      'name': instance.nameRM,
      '_updatedAt': instance.updatedAtRM,
      't': instance.type,
      'usernames': instance.usernames,
    };
