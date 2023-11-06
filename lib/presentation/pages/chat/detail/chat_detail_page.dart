import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application/design_system_widgets/app_error_widget.dart';
import 'package:flutter_application/design_system_widgets/app_loading_overlay.dart';
import 'package:flutter_application/design_system_widgets/app_loading_widget.dart';
import 'package:flutter_application/design_system_widgets/form_field/app_text_form_field.dart';
import 'package:flutter_application/domain/entities/message_entity.dart';
import 'package:flutter_application/domain/entities/room_entity.dart';
import 'package:flutter_application/presentation/blocs/chat/chat_bloc.dart';
import 'package:flutter_application/presentation/blocs/chat/chat_state.dart';
import 'package:flutter_application/presentation/pages/chat/detail/widgets/message_item_widget.dart';
import 'package:flutter_application/presentation/pages/chat/detail/widgets/message_separator_widget.dart';
import 'package:flutter_application/presentation/pages/chat/detail/widgets/record_widget.dart';
import 'package:flutter_application/presentation/pages/chat/detail/widgets/select_file_option_widget.dart';
import 'package:flutter_application/presentation/pages/chat/detail/widgets/sending_file_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stream_paging/fl_stream_paging.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tuple/tuple.dart';

import '../../../../initialize_dependencies.dart';

class ChatDetailPage extends StatefulWidget {
  static const path = '/chat_detail_page';
  const ChatDetailPage({Key? key, required this.roomEntity}) : super(key: key);
  final RoomEntity roomEntity;

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  OverlayEntry? overlayEntry;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(
        localService: sl.get(),
        chatService: sl.get(),
        roomEntity: widget.roomEntity,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(widget.roomEntity.name ?? ''),
        ),
        body: BlocConsumer<ChatBloc, ChatState>(builder: (context, state) {
          return state.when(
            (textEditingController,
                    messageDataSource,
                    chatActionStatus,
                    realtimeChatActionStatus,
                    currentMessage,
                    recordProgressTimer,
                    textFieldFocusNode,
                    realtimeMessage) =>
                PagingListView<int, MessageEntity>.separated(
              reverse: true,
              separatorBuilder: (_, index, item, items) {
                if (index < items.length - 1) {
                  final nextItem = items[index + 1];
                  if (DateTime.parse(nextItem.updatedAt).day !=
                      DateTime.parse(item.updatedAt).day) {
                    return MessageSeparatorWidget(date: item.updatedAt);
                  } else {
                    return SizedBox(
                      height: 8,
                    );
                  }
                } else {
                  return MessageSeparatorWidget(date: item.updatedAt);
                }
              },
              builderDelegate: PagedChildBuilderDelegate<MessageEntity>(
                itemBuilder:
                    (context, data, child, onUpdate, onDelete, dataList) {
                  final index = dataList.indexOf(data);
                  final isEndList = index == dataList.length - 1;
                  final continuous = !isEndList &&
                      data.attachmentStatus == AttachmentStatus.none &&
                      DateTime.parse(data.updatedAt).millisecondsSinceEpoch -
                              DateTime.parse(dataList[index + 1].updatedAt)
                                  .millisecondsSinceEpoch <
                          600000;
                  return BlocListener<ChatBloc, ChatState>(
                    listener: (context, state) {
                      if (state.mapOrNull((value) => value.chatActionStatus) ==
                          ChatActionStatus.edited) {
                        context
                            .read<ChatBloc>()
                            .sendMessageToServer()
                            .then((value) {
                          log('onUpdate: ${value.msg} -- ${value.id}');
                          onUpdate(value);
                        });
                      }
                      if (state.mapOrNull(
                              (value) => value.realtimeChatActionStatus) ==
                          ChatActionStatus.realtimeUpdate) {
                        final updateMessage = context
                            .read<ChatBloc>()
                            .state
                            .mapOrNull((value) => value.realtimeMessageEntity)!;
                        log('onUpdate: ${updateMessage.msg} -- ${updateMessage.id}');
                        onUpdate(updateMessage);
                      }
                    },
                    listenWhen: (oldState, currState) {
                      return (currState.mapOrNull(
                                      (value) => value.chatActionStatus) ==
                                  ChatActionStatus.edited &&
                              currState
                                      .mapOrNull((value) => value.messageEntity)
                                      ?.id ==
                                  data.id) ||
                          (currState.mapOrNull((value) =>
                                      value.realtimeChatActionStatus) ==
                                  ChatActionStatus.realtimeUpdate &&
                              currState
                                      .mapOrNull((value) =>
                                          value.realtimeMessageEntity)
                                      ?.id ==
                                  data.id);
                    },
                    child: isEndList
                        ? Column(
                            children: [
                              MessageSeparatorWidget(date: data.updatedAt),
                              MessageItemWidget(
                                item: data,
                                key: ValueKey(data.id),
                                onUpdate: (message) {
                                  // textFieldFocusNode?.requestFocus();
                                  context
                                      .read<ChatBloc>()
                                      .edit(messageEntity: message);
                                },
                                onDelete: onDelete,
                                continuous: continuous,
                              ),
                            ],
                          )
                        : MessageItemWidget(
                            item: data,
                            key: ValueKey(data.id),
                            onUpdate: (message) {
                              // textFieldFocusNode?.requestFocus();
                              context
                                  .read<ChatBloc>()
                                  .edit(messageEntity: message);
                            },
                            onDelete: onDelete,
                            continuous: continuous,
                          ),
                  );
                },
              ),
              pageDataSource: messageDataSource,
              errorBuilder: (_, e) => AppErrorWidget(
                error: e.toString(),
              ),
              isEnablePullToRefresh: false,
              addItemBuilder: (context, onAddItem) {
                return BlocListener<ChatBloc, ChatState>(
                    listener: (context, state) async {
                      if (state.mapOrNull((value) => value.chatActionStatus) ==
                          ChatActionStatus.send) {
                        overlayEntry = AppLoadingOverlay();
                        Overlay.of(context).insert(overlayEntry!);
                        await context
                            .read<ChatBloc>()
                            .sendMessageToServer()
                            .then((value) => onAddItem(value));
                      }
                      if (state.mapOrNull(
                              (value) => value.realtimeChatActionStatus) ==
                          ChatActionStatus.realtimeAdd) {
                        final updateMessage = context
                            .read<ChatBloc>()
                            .state
                            .mapOrNull((value) => value.realtimeMessageEntity)!;
                        onAddItem(updateMessage);
                      }
                    },
                    listenWhen: (oldState, currState) {
                      final oldStatus =
                          oldState.mapOrNull((value) => value.chatActionStatus);
                      final currStatus = currState
                          .mapOrNull((value) => value.chatActionStatus);
                      final realtimeOldStatus = oldState
                          .mapOrNull((value) => value.realtimeChatActionStatus);
                      final realtimeCurrStatus = currState
                          .mapOrNull((value) => value.realtimeChatActionStatus);
                      return (oldStatus != currStatus &&
                              currStatus == ChatActionStatus.send) ||
                          (realtimeOldStatus != realtimeCurrStatus &&
                              realtimeCurrStatus ==
                                  ChatActionStatus.realtimeAdd);
                    },
                    child: (chatActionStatus == ChatActionStatus.recordAudio)
                        ? RecordWidget(
                            onClose: context.read<ChatBloc>().closeRecorder,
                            onSend: context.read<ChatBloc>().send,
                          )
                        : AppTextFormField(
                            textEditingController: textEditingController,
                            focusNode: textFieldFocusNode,
                            hint: 'New message',
                            suffix: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      context.read<ChatBloc>().selectOption();
                                    },
                                    icon: Icon(Icons.add)),
                                IconButton(
                                    onPressed: () async {
                                      await context.read<ChatBloc>().record();
                                    },
                                    icon: Icon(Icons.mic_none)),
                              ],
                            ),
                            typingSuffix: IconButton(
                              onPressed: context.read<ChatBloc>().send,
                              icon: Icon(Icons.send),
                            ),
                            prefix: state.mapOrNull(
                                        (value) => value.chatActionStatus) ==
                                    ChatActionStatus.editing
                                ? IconButton(
                                    onPressed: () {
                                      context.read<ChatBloc>().cancelEdit();
                                    },
                                    icon: Icon(Icons.close),
                                  )
                                : IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.emoji_emotions_outlined),
                                  ),
                            onChanged: (v) {
                              log('onChanged: $v -- ${textEditingController.text}');
                            },
                          ));
              },
              newPageProgressIndicatorBuilder: (_, onLoadMore) => SizedBox(),
            ),
            loading: () => AppLoadingWidget(),
            error: (error) => AppErrorWidget(
              error: error.toString(),
            ),
          );
        }, listener: (context, state) async {
          state.mapOrNull((value) async {
            log('value.chatActionStatus: ${value.chatActionStatus}');
            switch (value.chatActionStatus) {
              case ChatActionStatus.selectOption:
                final pickFileOptions = [
                  Tuple3(Icons.camera_alt, 'Take a photo', () async {
                    await context
                        .read<ChatBloc>()
                        .pickFile(status: AttachmentStatus.image)
                        .then((value) => null);
                  }),
                  Tuple3(Icons.video_call_outlined, 'Take a video', () async {
                    await context
                        .read<ChatBloc>()
                        .pickFile(status: AttachmentStatus.video);
                  }),
                  Tuple3(Icons.library_add, 'Choose from library', () async {
                    await context.read<ChatBloc>().pickFile(
                        status: AttachmentStatus.image,
                        source: ImageSource.gallery);
                  }),
                  Tuple3(Icons.attach_file, 'Choose file', () async {
                    await context
                        .read<ChatBloc>()
                        .pickFile(status: AttachmentStatus.file);
                  }),
                  Tuple3(Icons.comment, 'Create discussion', () {}),
                ];
                await showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    builder: (contextDialog) {
                      return SelectActionWidget(
                        pickFileOptions: pickFileOptions,
                        height: 240,
                      );
                    }).then((value) => context.read<ChatBloc>().closeSend());
                break;
              case ChatActionStatus.sendingImage:
              case ChatActionStatus.sendingVideo:
              case ChatActionStatus.sendingFile:
                await showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    builder: (contextDialog) {
                      return SendingFileWidget(
                        roomName: widget.roomEntity.name ?? '',
                        messageEntity: value.messageEntity!,
                        onSend: (v) {
                          context.read<ChatBloc>().send(description: v);
                        },
                        chatActionStatus: value.chatActionStatus,
                        onClose: context.read<ChatBloc>().closeSend,
                      );
                    }).then((value) => context.read<ChatBloc>().closeSend());
                break;
              case ChatActionStatus.close:
                overlayEntry?.remove();
                overlayEntry = null;
                Navigator.pop(context);
                break;
              default:
                overlayEntry?.remove();
                overlayEntry = null;
                break;
            }
          });
        }),
      ),
    );
  }
}
