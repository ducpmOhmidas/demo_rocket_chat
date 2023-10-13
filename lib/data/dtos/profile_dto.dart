import 'package:flutter_application/domain/entities/profile_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_dto.g.dart';

@JsonSerializable()
class ProfileDto extends ProfileEntity {
  factory ProfileDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDtoToJson(this);

  ProfileDto(this.name, this.id);

  @override
  String name;

  @override
  String? get email {
    if (emails != null && emails!.isNotEmpty) {
      return emails!.first['address'];
    } else {
      return null;
    }
  }

  List<Map<String, dynamic>>? emails;

  @override
  @JsonKey(name: '_id')
  String id;
}
