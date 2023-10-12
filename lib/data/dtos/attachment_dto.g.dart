// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachmentDto _$AttachmentDtoFromJson(Map<String, dynamic> json) =>
    AttachmentDto(
      json['audio_size'] as int?,
      json['audio_url'] as String?,
      json['description'] as String?,
      json['format'] as String?,
      json['size'] as int?,
      json['id'] as int?,
      json['image_size'] as int?,
      json['image_url'] as String?,
      json['title'] as String?,
      json['title_link'] as String?,
    );

Map<String, dynamic> _$AttachmentDtoToJson(AttachmentDto instance) =>
    <String, dynamic>{
      'audio_size': instance.audioSize,
      'audio_url': instance.audioUrl,
      'description': instance.fileDescription,
      'format': instance.fileFormat,
      'size': instance.fileSize,
      'id': instance.id,
      'image_size': instance.imageSize,
      'image_url': instance.imageUrl,
      'title': instance.title,
      'title_link': instance.titleLink,
    };
