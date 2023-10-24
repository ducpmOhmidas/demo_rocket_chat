import 'package:flutter/material.dart';
import 'package:flutter_application/application/services/chat_service.dart';
import 'package:flutter_application/design_system_widgets/app_error_widget.dart';
import 'package:flutter_application/design_system_widgets/app_loading_widget.dart';
import 'package:flutter_application/design_system_widgets/image/app_image_widget.dart';
import 'package:flutter_application/domain/entities/message_entity.dart';
import 'package:flutter_application/presentation/blocs/message/message_bloc.dart';
import 'package:flutter_application/presentation/blocs/message/message_state.dart';
import 'package:flutter_application/presentation/pages/chat/detail/widgets/attachment_content_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../initialize_dependencies.dart';

class MessageItemWidget extends StatefulWidget {
  const MessageItemWidget({Key? key, required this.item}) : super(key: key);
  final MessageEntity item;

  @override
  State<MessageItemWidget> createState() => _MessageItemWidgetState();
}

class _MessageItemWidgetState extends State<MessageItemWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageBloc(
        data: widget.item,
        chatService: sl.get<ChatService>(),
      ),
      child: BlocConsumer<MessageBloc, MessageState>(
          builder: (context, state) {
            return state.when(
                (data, mediaFile, mediaLoading) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppImageWidget(url: 'url'),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(data.userInfor?.name ?? ''),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    data.updatedAt ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall,
                                  )
                                ],
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 160,
                                child: AttachmentContentWidget(item: data),
                              ),
                              Text(data.msg ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall),
                            ],
                          ),
                        )
                      ],
                    ),
                loading: () => SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: AppLoadingWidget(),
                    ),
                error: (error) => SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: AppErrorWidget(error: error),
                    ));
          },
          listener: (context, state) {}),
    );
  }
}
