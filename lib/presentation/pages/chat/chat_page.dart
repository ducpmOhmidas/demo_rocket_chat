import 'package:flutter/material.dart';
import 'package:flutter_application/application/services/local_service.dart';
import 'package:flutter_application/design_system_widgets/app_error_widget.dart';
import 'package:flutter_application/design_system_widgets/app_loading_widget.dart';
import 'package:flutter_application/domain/repositories/room/room_repository.dart';
import 'package:flutter_application/presentation/blocs/room/room_bloc.dart';
import 'package:flutter_application/presentation/blocs/room/room_state.dart';
import 'package:flutter_application/presentation/pages/chat/widgets/room_item_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../initialize_dependencies.dart';

class ChatPage extends StatefulWidget {
  static const path = '/chat_page';
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoomBloc(
          roomRepository: sl.get<RoomRepository>(),
          localService: sl.get<LocalService>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chat Page'),
        ),
        body: BlocConsumer<RoomBloc, RoomState>(
          builder: (context, state) {
            return state.when(
                (rooms) => ListView.separated(
                      itemBuilder: (context, index) {
                        final item = rooms[index];
                        return RoomItemWidget(item: item);
                      },
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 54),
                          child: Divider(),
                        );
                      },
                      itemCount: rooms.length,
                      padding: EdgeInsets.all(16),
                    ),
                loading: () => AppLoadingWidget(),
                error: (error) => AppErrorWidget(error: error.toString()));
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
