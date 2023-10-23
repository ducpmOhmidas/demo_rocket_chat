import 'package:flutter_application/domain/entities/attachment_entity.dart';
import 'package:flutter_application/domain/entities/profile_entity.dart';

enum AttachmentStatus {
  file,
  image,
  video,
  audio,
  none,
}

abstract class MessageEntity {
  String get id;

  String? get rid;

  String? msg;
  String? updatedAt;

  List<ProfileEntity>? get userMentions;

  ProfileEntity? get userInfor;

  List<AttachmentEntity>? get attachments;

  AttachmentStatus get attachmentStatus;
}
