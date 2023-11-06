import 'package:flutter_application/domain/entities/profile_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_state.freezed.dart';

@freezed
abstract class UserState with _$UserState {
  const factory UserState(ProfileEntity profile, String avatarPath) = UserStateData;
  const factory UserState.loading() = UserStateLoading;
  const factory UserState.error(dynamic error) = UserStateError;
}