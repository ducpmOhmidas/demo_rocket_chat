import 'package:flutter/material.dart';
import 'package:flutter_application/domain/entities/room_entity.dart';
import 'package:flutter_application/presentation/blocs/home/home_bloc.dart';
import 'package:flutter_application/presentation/pages/chat/chat_page.dart';
import 'package:flutter_application/presentation/pages/chat/detail/chat_detail_page.dart';
import 'package:flutter_application/presentation/pages/forms/forms_page.dart';
import 'package:flutter_application/presentation/pages/home/home_page.dart';
import 'package:flutter_application/utils/navigator_support.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainNavigator extends StatefulWidget {
  static const path = '/main_navigator';

  const MainNavigator({Key? key}) : super(key: key);

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return HomeBloc();
      },
      child: NavigatorSupport(
        initialRoute: HomePage.path,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case HomePage.path:
              return MaterialPageRoute(builder: (context) => const HomePage());
            case FormsPage.path:
              return MaterialPageRoute(builder: (context) => const FormsPage());
            case ChatPage.path:
              return MaterialPageRoute(builder: (context) => const ChatPage());
            case ChatDetailPage.path:
              final roomEntity = settings.arguments as RoomEntity;
              return MaterialPageRoute(
                  builder: (context) => ChatDetailPage(
                        roomEntity: roomEntity,
                      ));
            default:
              return MaterialPageRoute(builder: (context) => Container());
          }
        },
      ),
    );
  }
}
