import 'package:flutter_application/domain/models/authentication_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'authentication_dto.g.dart';

@JsonSerializable()
class AuthenticationDto extends AuthenticationModel {
  AuthenticationDto(this.accessToken, this.refreshToken);

  @override
  String accessToken;

  @override
  String refreshToken;

  factory AuthenticationDto.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationDtoToJson(this);
}
