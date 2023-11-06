import 'dart:io';

import 'package:flutter_application/application/services/user_service.dart';
import 'package:flutter_application/presentation/blocs/user/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/profile_entity.dart';

class UserBloc extends Cubit<UserState> {
  UserBloc({required ProfileEntity profile, required UserService userService})
      : _userService = userService,
        super(UserState.loading()) {
    init(profile: profile);
  }

  final UserService _userService;

  Future init({required ProfileEntity profile}) async {
    final avatarFile = await _userService.getAvatar(profileEntity: profile);
    // emit(UserStateData(profile, avatarFile.path));
  }
}
