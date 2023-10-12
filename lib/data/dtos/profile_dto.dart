import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_application/domain/models/profile_model.dart';
part 'profile_dto.g.dart';

@JsonSerializable()
class ProfileDto extends ProfileModel {
  factory ProfileDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDtoToJson(this);

  ProfileDto(this.name, this.email, this.id);

  @override
  String name;

  @override
  String? email;

  @override
  @JsonKey(name: '_id')
  String id;
}
