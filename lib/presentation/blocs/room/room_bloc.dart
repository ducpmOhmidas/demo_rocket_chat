import 'package:flutter_application/application/services/local_service.dart';
import 'package:flutter_application/domain/repositories/room/room_repository.dart';
import 'package:flutter_application/presentation/blocs/room/room_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomBloc extends Cubit<RoomState> {
  RoomBloc(
      {required RoomRepository roomRepository,
      required LocalService localService})
      : _roomRepository = roomRepository,
        _localService = localService,
        super(RoomState.loading()) {
    init();
  }
  final RoomRepository _roomRepository;
  final LocalService _localService;

  Future init() async {
    _roomRepository
        .getAll()
        .then((rooms) => emit(RoomStateData(rooms)))
        .catchError((error) => emit(RoomStateError(error)));
  }

  Future<bool> checkNavDetail() {
    return _localService.handleStoragePermission();
  }
}
