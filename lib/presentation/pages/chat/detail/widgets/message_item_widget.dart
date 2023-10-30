import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application/application/services/chat_service.dart';
import 'package:flutter_application/design_system_widgets/app_error_widget.dart';
import 'package:flutter_application/design_system_widgets/app_loading_widget.dart';
import 'package:flutter_application/design_system_widgets/image/app_image_widget.dart';
import 'package:flutter_application/domain/entities/message_entity.dart';
import 'package:flutter_application/presentation/blocs/message/message_bloc.dart';
import 'package:flutter_application/presentation/blocs/message/message_state.dart';
import 'package:flutter_application/presentation/pages/chat/detail/widgets/attachment/attachment_content_widget.dart';
import 'package:flutter_application/presentation/pages/chat/detail/widgets/select_file_option_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

import '../../../../../design_system_widgets/app_loading_overlay.dart';
import '../../../../../initialize_dependencies.dart';

class MessageItemWidget extends StatefulWidget {
  const MessageItemWidget(
      {Key? key,
      required this.item,
      required this.onUpdate,
      required this.onDelete})
      : super(key: key);
  final MessageEntity item;
  final Function(MessageEntity messageEntity) onUpdate;
  final Function() onDelete;

  @override
  State<MessageItemWidget> createState() => _MessageItemWidgetState();
}

class _MessageItemWidgetState extends State<MessageItemWidget> {
  OverlayEntry? overlayEntry;

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
              (data,
                      mediaFile,
                      mediaLoading,
                      messageActionStatus,
                      videoController,
                      chewieController,
                      audioController,
                      errorMsg) {
                if (widget.item != data) {
                  context.read<MessageBloc>().updateMessage(messageEntity: widget.item);
                  log('MessageItemWidget: ${data.msg}');
                }
                  return InkWell(
                  onLongPress: context.read<MessageBloc>().showAction,
                  child: Row(
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
                                  style:
                                  Theme.of(context).textTheme.bodySmall,
                                )
                              ],
                            ),
                            AttachmentContentWidget(
                              item: data,
                            ),
                            Text(data.msg ?? '',
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
                  ,
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
        listener: (context, state) {
          switch (state.mapOrNull((value) => value.messageActionStatus)) {
            case MessageActionStatus.showAction:
              showModalBottomSheet(
                  context: context,
                  builder: (contextDialog) {
                    final actions = [
                      Tuple3(Icons.copy, 'Copy', () async {}),
                      Tuple3(Icons.share, 'Share', () async {}),
                      Tuple3(Icons.edit, 'Edit', () async {
                        context.read<MessageBloc>().closeAction();
                        final message = state.mapOrNull((value) => value.data)!;
                        widget
                            .onUpdate(message);
                      }),
                      Tuple3(Icons.report, 'Report', () async {}),
                      Tuple3(Icons.delete, 'Delete', () async {
                        await context.read<MessageBloc>().delete();
                      }),
                    ];
                    return SelectActionWidget(
                      pickFileOptions: actions,
                    );
                  }).then((value) => context.read<MessageBloc>().initAction());
              break;
            case MessageActionStatus.delete:
              Navigator.pop(context);
              overlayEntry = AppLoadingOverlay();
              Overlay.of(context).insert(overlayEntry!);
              break;
            case MessageActionStatus.completedDelete:
              overlayEntry?.remove();
              overlayEntry = null;
              widget.onDelete();
              break;
            case MessageActionStatus.close:
              overlayEntry?.remove();
              overlayEntry = null;
              Navigator.pop(context);
              break;
            default:
              overlayEntry?.remove();
              overlayEntry = null;
              break;
          }
        },
        listenWhen: (oldState, currState) {
          return oldState.mapOrNull((value) => value.messageActionStatus) !=
              currState.mapOrNull((value) => value.messageActionStatus);
        },
      ),
    );
  }
}
