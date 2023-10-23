import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/room_entity.dart';
part 'room_state.freezed.dart';

@freezed
abstract class RoomState with _$RoomState { 
  const factory RoomState(List<RoomEntity> rooms) = RoomStateData;
  const factory RoomState.loading() = RoomStateLoading;
  const factory RoomState.error(dynamic error) = RoomStateError;
}