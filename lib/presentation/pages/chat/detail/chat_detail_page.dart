import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application/data/data_sources/paging/chat_data_source.dart';
import 'package:flutter_application/data/dtos/message_dto.dart';
import 'package:flutter_application/data/dtos/profile_dto.dart';
import 'package:flutter_application/design_system_widgets/app_error_widget.dart';
import 'package:flutter_application/design_system_widgets/app_loading_widget.dart';
import 'package:flutter_application/design_system_widgets/form_field/app_text_form_field.dart';
import 'package:flutter_application/domain/entities/message_entity.dart';
import 'package:flutter_application/domain/entities/room_entity.dart';
import 'package:flutter_application/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_application/presentation/blocs/chat/chat_bloc.dart';
import 'package:flutter_application/presentation/blocs/chat/chat_state.dart';
import 'package:flutter_application/presentation/pages/chat/detail/widgets/message_item_widget.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(
        localService: sl.get(),
        roomEntity: widget.roomEntity,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.roomEntity.name ?? ''),
        ),
        body: BlocConsumer<ChatBloc, ChatState>(builder: (context, state) {
          return state.when(
            (textEditingController, messageDataSource, chatActionStatus,
                    currentMessage) =>
                PagingListView<int, MessageEntity>.separated(
              reverse: true,
              separatorBuilder: (_, index) => SizedBox(
                height: 16,
              ),
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context, data, child, onUpdate, onDelete) {
                  return MessageItemWidget(
                    item: data,
                    key: ValueKey(data.id),
                  );
                },
              ),
              pageDataSource: messageDataSource,
              errorBuilder: (_, e) => AppErrorWidget(
                error: e.toString(),
              ),
              isEnablePullToRefresh: false,
              addItemBuilder: (context, onAddItem) {
                return AppTextFormField(
                  textEditingController: textEditingController,
                  hint: 'New message',
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            context.read<ChatBloc>().selectOption();
                          },
                          icon: Icon(Icons.add)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.mic_none)),
                    ],
                  ),
                  typingSuffix: IconButton(
                    onPressed: () {
                      // onAddItem(MessageDto(
                      //     DateTime.now().hashCode.toString(),
                      //     widget.roomEntity.id,
                      //     null,
                      //     textEditingController.text,
                      //     context.read<AuthBloc>().state.mapOrNull(
                      //         authorized: (v) => ProfileDto(
                      //             v.profileModel.name, v.profileModel.id)),
                      //     null));
                      textEditingController.clear();
                    },
                    icon: Icon(Icons.send),
                  ),
                  prefix: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.emoji_emotions_outlined),
                  ),
                  onChanged: (v) {
                    log('onChanged: $v -- ${textEditingController.text}');
                  },
                );
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
                    builder: (context) {
                      return SelectFileOptionWidget(
                        pickFileOptions: pickFileOptions,
                      );
                    }).then((value) => context.read<ChatBloc>().closeDialog());
                break;
              case ChatActionStatus.sendingImage:
              case ChatActionStatus.sendingVideo:
              case ChatActionStatus.sendingFile:
                await showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SendingFileWidget(
                        roomName: widget.roomEntity.name ?? '',
                        messageEntity: value.messageEntity!,
                        onSend: (v) {
                          log('onSend: $v');
                        },
                        chatActionStatus: value.chatActionStatus,
                      );
                    }).then((value) => context.read<ChatBloc>().closeDialog());
                break;
              case ChatActionStatus.close:
                Navigator.pop(context);
                break;
              default:
                break;
            }
          });
        }),
      ),
    );
  }
}
