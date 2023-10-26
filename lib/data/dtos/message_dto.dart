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

  MessageDto({
    required this.id,
    this.rid,
    this.mentionsRM,
    this.msg,
    this.userInforRM,
    this.attachmentsRM,
  });


  @override
  @JsonKey(name: '_id')
  String id;

  @override
  @JsonKey(name: 'rid')
  String? rid;

  @JsonKey(name: 'mentions')
  List<ProfileDto>? mentionsRM;

  @override
  List<ProfileEntity>? get userMentions {
    if (mentionsRM != null && mentionsRM!.isNotEmpty) {
      return mentionsRM;
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
  List<AttachmentDto>? attachmentsRM;

  @override
  List<AttachmentEntity>? get attachments {
    if (attachmentsRM != null && attachmentsRM!.isNotEmpty) {
      return attachmentsRM;
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

  MessageDto copyWith({
    String? id,
    String? rid,
    List<ProfileDto>? mentionsRM,
    String? msg,
    ProfileDto? userInforRM,
    List<AttachmentDto>? attachmentsRM,
  }) {
    return MessageDto(
      id: id ?? this.id,
      rid: rid ?? this.rid,
      mentionsRM: mentionsRM ?? this.mentionsRM,
      msg: msg ?? this.msg,
      userInforRM: userInforRM ?? this.userInforRM,
      attachmentsRM: attachmentsRM ?? this.attachmentsRM,
    );
  }

}
