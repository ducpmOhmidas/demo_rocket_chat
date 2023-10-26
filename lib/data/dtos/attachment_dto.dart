import 'package:flutter_application/domain/entities/attachment_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attachment_dto.g.dart';

@JsonSerializable()
class AttachmentDto extends AttachmentEntity {
  factory AttachmentDto.fromJson(Map<String, dynamic> json) =>
      _$AttachmentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentDtoToJson(this);


  @override
  @JsonKey(name: 'audio_size')
  int? audioSize;

  @override
  @JsonKey(name: 'audio_url')
  String? audioUrl;

  @override
  @JsonKey(name: 'description')
  String? fileDescription;

  @override
  @JsonKey(name: 'format')
  String? fileFormat;

  @override
  @JsonKey(name: 'size')
  int? fileSize;

  @override
  int? id;

  @override
  @JsonKey(name: 'image_size')
  int? imageSize;

  @override
  @JsonKey(name: 'image_url')
  String? imageUrl;

  @override
  @JsonKey(name: 'title')
  String? title;

  @override
  @JsonKey(name: 'title_link')
  String? titleLink;

  @override
  String? type;

  @override
  @JsonKey(name: 'video_url')
  String? videoUrl;

  AttachmentDto({
    this.audioSize,
    this.audioUrl,
    this.fileDescription,
    this.fileFormat,
    this.fileSize,
    this.id,
    this.imageSize,
    this.imageUrl,
    this.title,
    this.titleLink,
    this.type,
    this.videoUrl,
  });

  AttachmentDto copyWith({
    int? audioSize,
    String? audioUrl,
    String? fileDescription,
    String? fileFormat,
    int? fileSize,
    int? id,
    int? imageSize,
    String? imageUrl,
    String? title,
    String? titleLink,
    String? type,
    String? videoUrl,
  }) {
    return AttachmentDto(
      audioSize: audioSize ?? this.audioSize,
      audioUrl: audioUrl ?? this.audioUrl,
      fileDescription: fileDescription ?? this.fileDescription,
      fileFormat: fileFormat ?? this.fileFormat,
      fileSize: fileSize ?? this.fileSize,
      id: id ?? this.id,
      imageSize: imageSize ?? this.imageSize,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      titleLink: titleLink ?? this.titleLink,
      type: type ?? this.type,
      videoUrl: videoUrl ?? this.videoUrl,
    );
  }
}
