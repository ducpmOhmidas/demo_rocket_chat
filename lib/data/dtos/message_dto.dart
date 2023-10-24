import 'package:flutter_application/data/dtos/attachment_dto.dart';
import 'package:flutter_application/data/dtos/profile_dto.dart';
import 'package:flutter_application/domain/entities/message_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/attachment_entity.dart';
import '../../domain/entities/profile_entity.dart';

part 'message_dto.g.dart';

@JsonSerializable()
class MessageDto extends MessageEntity {
  factory MessageDto.fromJson(Map<String, dynamic> json) =>
      _$MessageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDtoToJson(this);

  MessageDto(this.id, this.rid, this.mentionsRM, this.msg, this.userInforRM,
      this.attachmentsRM);

  @override
  @JsonKey(name: '_id')
  String id;

  @override
  @JsonKey(name: 'rid')
  String? rid;

  @JsonKey(name: 'mentions')
  List<Map<String, dynamic>>? mentionsRM;

  @override
  List<ProfileEntity>? get userMentions {
    if (mentionsRM != null && mentionsRM!.isNotEmpty) {
      return mentionsRM!.map((e) => ProfileDto.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  @override
  String? msg;

  @override
  @JsonKey(name: '_updatedAt')
  String? get updatedAt;

  @JsonKey(name: 'u')
  ProfileDto? userInforRM;

  @override
  ProfileEntity? get userInfor {
    if (userInforRM != null) {
      return userInforRM;
    } else {
      return null;
    }
  }

  @JsonKey(name: 'attachments')
  List<Map<String, dynamic>>? attachmentsRM;

  @override
  List<AttachmentEntity>? get attachments {
    if (attachmentsRM != null && attachmentsRM!.isNotEmpty) {
      return attachmentsRM!.map((e) => AttachmentDto.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  @override
  AttachmentStatus get attachmentStatus {
    if (attachments != null && attachments!.isNotEmpty) {
      if (attachments!.first.fileFormat != null) {
        return AttachmentStatus.file;
      }
      if (attachments!.first.imageUrl != null) {
        return AttachmentStatus.image;
      }
      if (attachments!.first.videoUrl != null) {
        return AttachmentStatus.video;
      }
      if (attachments!.first.audioUrl != null) {
        return AttachmentStatus.audio;
      }
      return AttachmentStatus.none;
    } else {
      return AttachmentStatus.none;
    }
  }
}
