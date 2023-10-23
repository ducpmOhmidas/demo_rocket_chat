import 'package:flutter_application/data/data_sources/api_data_source.dart';
import 'package:flutter_application/domain/entities/room_entity.dart';
import 'package:flutter_application/domain/repositories/room/room_repository.dart';
import 'package:flutter_application/utils/array_extension.dart';


class RoomRepositoryImpl implements RoomRepository {
  final _apiDataSource = ApiDataSource();
  @override
  Future<List<RoomEntity>> getAll() async {
    final rooms = await _apiDataSource.fetchRooms();
    return rooms;
  }
}