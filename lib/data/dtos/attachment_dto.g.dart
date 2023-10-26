// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachmentDto _$AttachmentDtoFromJson(Map<String, dynamic> json) =>
    AttachmentDto(
      audioSize: json['audio_size'] as int?,
      audioUrl: json['audio_url'] as String?,
      fileDescription: json['description'] as String?,
      fileFormat: json['format'] as String?,
      fileSize: json['size'] as int?,
      id: json['id'] as int?,
      imageSize: json['image_size'] as int?,
      imageUrl: json['image_url'] as String?,
      title: json['title'] as String?,
      titleLink: json['title_link'] as String?,
      type: json['type'] as String?,
      videoUrl: json['video_url'] as String?,
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
      'type': instance.type,
      'video_url': instance.videoUrl,
    };
