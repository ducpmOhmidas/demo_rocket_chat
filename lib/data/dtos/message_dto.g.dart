// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageDto _$MessageDtoFromJson(Map<String, dynamic> json) => MessageDto(
      json['_id'] as String,
      json['rid'] as String?,
      (json['mentions'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      json['msg'] as String?,
      json['u'] as Map<String, dynamic>?,
      (json['attachments'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    )..updatedAt = json['_updatedAt'] as String?;

Map<String, dynamic> _$MessageDtoToJson(MessageDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'rid': instance.rid,
      'mentions': instance.mentionsRM,
      'msg': instance.msg,
      '_updatedAt': instance.updatedAt,
      'u': instance.userInforRM,
      'attachments': instance.attachmentsRM,
    };
