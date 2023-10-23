import 'package:flutter_application/domain/entities/room_entity.dart';

abstract class RoomRepository {
  Future<List<RoomEntity>> getAll();
}