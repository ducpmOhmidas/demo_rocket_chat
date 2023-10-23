import 'package:flutter/material.dart';
import 'package:flutter_application/data/data_sources/paging/chat_data_source.dart';
import 'package:flutter_application/design_system_widgets/app_error_widget.dart';
import 'package:flutter_application/domain/entities/message_entity.dart';
import 'package:flutter_application/domain/entities/room_entity.dart';
import 'package:flutter_application/presentation/pages/chat/detail/widgets/message_item_widget.dart';
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

  @override
  void initState() {
    super.initState();
    _messageDataSource = MessageDataSource(roomId: widget.roomEntity.id);
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
          return MessageItemWidget(item: data);
        }),
        pageDataSource: _messageDataSource,
        errorBuilder: (_, e) => AppErrorWidget(error: e.toString()),
        isEnablePullToRefresh: false,
      ),
    );
  }
}
