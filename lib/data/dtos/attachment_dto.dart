import 'package:flutter_application/domain/entities/attachment_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attachment_dto.g.dart';

@JsonSerializable()
class AttachmentDto extends AttachmentEntity {
  factory AttachmentDto.fromJson(Map<String, dynamic> json) =>
      _$AttachmentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentDtoToJson(this);

  AttachmentDto(
      this.audioSize,
      this.audioUrl,
      this.fileDescription,
      this.fileFormat,
      this.fileSize,
      this.id,
      this.imageSize,
      this.imageUrl,
      this.title,
      this.titleLink);

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
}
