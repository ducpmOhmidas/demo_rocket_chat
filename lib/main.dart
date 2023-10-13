import 'package:flutter/material.dart';
import 'package:flutter_application/application/application.dart';
import 'package:flutter_application/application/services/local_service.dart';
import 'package:flutter_application/initialize_dependencies.dart';
import 'package:flutter_application/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_application/presentation/blocs/auth_navigation/auth_navigation_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await initializeDependencies();

  if (GetIt.instance.get<LocalService>().isAuthorized()) {
    await GetIt.instance.get<AuthBloc>().initializeApp();
  }
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider.value(
        value: GetIt.instance.get<AuthBloc>(),
      ),
      BlocProvider.value(
        value: GetIt.instance.get<AuthNavigationBloc>(),
      ),
    ],
    child: Application(),
  ));
}
