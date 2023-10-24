import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application/data/data_sources/paging/chat_data_source.dart';
import 'package:flutter_application/data/dtos/message_dto.dart';
import 'package:flutter_application/data/dtos/profile_dto.dart';
import 'package:flutter_application/design_system_widgets/app_error_widget.dart';
import 'package:flutter_application/design_system_widgets/form_field/app_text_form_field.dart';
import 'package:flutter_application/domain/entities/message_entity.dart';
import 'package:flutter_application/domain/entities/room_entity.dart';
import 'package:flutter_application/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_application/presentation/pages/chat/detail/widgets/message_item_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stream_paging/fl_stream_paging.dart';

class ChatDetailPage extends StatefulWidget {
  static const path = '/chat_detail_page';
  const ChatDetailPage({Key? key, required this.roomEntity}) : super(key: key);
  final RoomEntity roomEntity;

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  late final MessageDataSource _messageDataSource;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _messageDataSource = MessageDataSource(roomId: widget.roomEntity.id);
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomEntity.name ?? ''),
      ),
      body: PagingListView<int, MessageEntity>.separated(
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
        }),
        pageDataSource: _messageDataSource,
        errorBuilder: (_, e) => AppErrorWidget(error: e.toString()),
        isEnablePullToRefresh: false,
        addItemBuilder: (context, onAddItem) {
          return AppTextFormField(
            textEditingController: _controller,
            hint: 'New message',
            suffix: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                IconButton(onPressed: () {}, icon: Icon(Icons.mic_none)),
              ],
            ),
            typingSuffix: IconButton(
              onPressed: () {
                onAddItem(MessageDto(
                    DateTime.now().hashCode.toString(),
                    widget.roomEntity.id,
                    null,
                    _controller.text,
                    context.read<AuthBloc>().state.mapOrNull(
                        authorized: (v) =>
                            ProfileDto(v.profileModel.name, v.profileModel.id)),
                    null));
                _controller.clear();
              },
              icon: Icon(Icons.send),
            ),
            prefix: IconButton(
              onPressed: () {},
              icon: Icon(Icons.emoji_emotions_outlined),
            ),
            onChanged: (v) {
              log('onChanged: $v -- ${_controller.text}');
            },
          );
        },
        newPageProgressIndicatorBuilder: (_, onLoadMore) => SizedBox(),
      ),
    );
  }
}
