import 'package:flutter_application/data/dtos/attachment_dto.dart';
import 'package:flutter_application/data/dtos/profile_dto.dart';
import 'package:flutter_application/domain/models/message_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'message_dto.g.dart';

@JsonSerializable()
class MessageDto extends MessageModel {

  factory MessageDto.fromJson(Map<String, dynamic> json) => _$MessageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDtoToJson(this);

  MessageDto(this.id, this.rid, this.mentions, this.msg);

  @override
  @JsonKey(name: '_id')
  String id;

  @override
  @JsonKey(name: 'rid')
  String rid;

  @override
  @JsonKey(name: 'mentions')
  List<ProfileDto>? mentions;

  @override
  String? msg;

  @override
  @JsonKey(name: '_updatedAt')
  String? get updatedAt;

  @override
  @JsonKey(name: 'u')
  ProfileDto? get userInfor;

  @override
  List<AttachmentDto>? attachments;
}
