import 'package:flutter_application/data/dtos/profile_dto.dart';
import 'package:flutter_application/domain/models/profile_model.dart';

import '../../data/dtos/attachment_dto.dart';

abstract class MessageModel {
  String get id;
  String get rid;
  String? msg;
  String? updatedAt;
  List<ProfileDto>? mentions;
  ProfileDto? userInfor;
  List<AttachmentDto>? attachments;
}