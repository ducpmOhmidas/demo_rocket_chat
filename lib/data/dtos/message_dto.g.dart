// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageDto _$MessageDtoFromJson(Map<String, dynamic> json) => MessageDto(
      id: json['_id'] as String,
      rid: json['rid'] as String?,
      mentionsRM: (json['mentions'] as List<dynamic>?)
          ?.map((e) => ProfileDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      msg: json['msg'] as String?,
      userInforRM: json['u'] == null
          ? null
          : ProfileDto.fromJson(json['u'] as Map<String, dynamic>),
      attachmentsRM: (json['attachments'] as List<dynamic>?)
          ?.map((e) => AttachmentDto.fromJson(e as Map<String, dynamic>))
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
