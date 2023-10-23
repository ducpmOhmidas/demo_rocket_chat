import 'package:flutter_application/application/services/auth_service.dart';
import 'package:flutter_application/application/services/local_service.dart';
import 'package:flutter_application/presentation/blocs/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../initialize_dependencies.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeState.loading());

  final AuthService authService = sl.get();

  Future fetchDefaultData() async {
    var data = await authService.defaultData();
    emit(HomeState(data));
  }
}
