import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/application/services/chat_service.dart';
import 'package:flutter_application/application/services/user_service.dart';
import 'package:flutter_application/design_system_widgets/app_error_widget.dart';
import 'package:flutter_application/design_system_widgets/app_loading_widget.dart';
import 'package:flutter_application/design_system_widgets/image/app_image_widget.dart';
import 'package:flutter_application/design_system_widgets/image/user_avatar_widget.dart';
import 'package:flutter_application/domain/entities/message_entity.dart';
import 'package:flutter_application/presentation/blocs/auth/auth_bloc.dart';
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
      required this.onDelete,
      this.continuous = false})
      : super(key: key);
  final MessageEntity item;
  final Function(MessageEntity messageEntity) onUpdate;
  final Function() onDelete;
  final bool continuous;

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
          userService: sl.get<UserService>()),
      child: BlocConsumer<MessageBloc, MessageState>(
        builder: (context, state) {
          return state.when((data,
                  mediaFile,
                  mediaLoading,
                  messageActionStatus,
                  videoController,
                  chewieController,
                  audioController,
                  errorMsg,
                  userAvatar) {
            if (widget.item != data) {
              context
                  .read<MessageBloc>()
                  .updateMessage(messageEntity: widget.item);
              log('MessageItemWidget: ${data.msg}');
            }
            return InkWell(
              onLongPress: context.read<MessageBloc>().showAction,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.continuous
                      ? SizedBox(width: 32,)
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: AppImageWidget(
                            url:
                                '/avatar/${data.userInfor?.userName}?format=png',
                            width: 32,
                            height: 32,
                          ),
                        ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.continuous ? SizedBox() : Row(
                          children: [
                            Text(data.userInfor?.name ?? ''),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              data.updatedAt.toString(),
                              style: Theme.of(context).textTheme.bodySmall,
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
          },
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  builder: (contextDialog) {
                    final actions =
                        state.mapOrNull((value) => value.data.userInfor?.id) !=
                                context.read<AuthBloc>().state.mapOrNull(
                                    authorized: (v) => v.profileModel.id)
                            ? [
                                Tuple3(Icons.copy, 'Copy',
                                    context.read<MessageBloc>().copy),
                                Tuple3(Icons.share, 'Share',
                                    context.read<MessageBloc>().share),
                                Tuple3(Icons.edit, 'Edit', () async {
                                  context.read<MessageBloc>().closeAction();
                                  final message =
                                      state.mapOrNull((value) => value.data)!;
                                  widget.onUpdate(message);
                                }),
                                Tuple3(Icons.report, 'Report',
                                    context.read<MessageBloc>().report),
                                Tuple3(Icons.delete, 'Delete',
                                    context.read<MessageBloc>().delete),
                              ]
                            : [
                                Tuple3(Icons.copy, 'Copy',
                                    context.read<MessageBloc>().copy),
                                Tuple3(Icons.share, 'Share',
                                    context.read<MessageBloc>().share),
                                Tuple3(Icons.edit, 'Edit', () async {
                                  context.read<MessageBloc>().closeAction();
                                  final message =
                                      state.mapOrNull((value) => value.data)!;
                                  widget.onUpdate(message);
                                }),
                                Tuple3(Icons.delete, 'Delete',
                                    context.read<MessageBloc>().delete),
                              ];
                    return SelectActionWidget(
                      pickFileOptions: actions,
                    );
                  }).then((value) => context.read<MessageBloc>().initAction());
              break;
            case MessageActionStatus.delete:
            case MessageActionStatus.report:
              Navigator.pop(context);
              overlayEntry = AppLoadingOverlay();
              Overlay.of(context).insert(overlayEntry!);
              break;
            case MessageActionStatus.completedDelete:
              overlayEntry?.remove();
              overlayEntry = null;
              widget.onDelete();
              break;
            case MessageActionStatus.completedReport:
              overlayEntry?.remove();
              overlayEntry = null;
              showDialog(
                  context: context,
                  builder: (contextDialog) {
                    return CupertinoAlertDialog(
                      title: Text('Report success'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(contextDialog);
                            },
                            child: Text('Ok'))
                      ],
                    );
                  });
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
