// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileDto _$ProfileDtoFromJson(Map<String, dynamic> json) => ProfileDto(
      json['name'] as String,
      json['_id'] as String,
    )
      ..email = json['email'] as String?
      ..emails = (json['emails'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList();

Map<String, dynamic> _$ProfileDtoToJson(ProfileDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'emails': instance.emails,
      '_id': instance.id,
    };
