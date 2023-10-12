// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageDto _$MessageDtoFromJson(Map<String, dynamic> json) => MessageDto(
      json['id'] as String,
      json['rid'] as String,
      (json['mentions'] as List<dynamic>?)
          ?.map((e) => ProfileDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['msg'] as String?,
    )
      ..updatedAt = json['updatedAt'] as String?
      ..userInfor = json['userInfor'] == null
          ? null
          : ProfileDto.fromJson(json['userInfor'] as Map<String, dynamic>);

Map<String, dynamic> _$MessageDtoToJson(MessageDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rid': instance.rid,
      'mentions': instance.mentions,
      'msg': instance.msg,
      'updatedAt': instance.updatedAt,
      'userInfor': instance.userInfor,
    };
