import 'package:flutter_application/data/data_sources/api_data_source.dart';
import 'package:flutter_application/domain/entities/message_entity.dart';
import 'package:flutter_stream_paging/data_source/data_source.dart';
import 'package:tuple/tuple.dart';

class MessageDataSource extends DataSource<int, MessageEntity> {
  MessageDataSource({required this.roomId, required this.roomType})
      : super(pageSize: 10);

  final _apiDataSource = ApiDataSource();

  final String roomId;
  final String roomType;

  @override
  Future<Tuple2<List<MessageEntity>, int>> loadInitial(int pageSize) async {
    return Tuple2(
        await _apiDataSource.fetchMessages(
            roomId: roomId, offset: 0, total: pageSize, type: roomType),
        1);
  }

  @override
  Future<Tuple2<List<MessageEntity>, int>> loadPageAfter(
      int params, int pageSize) async {
    return Tuple2(
        await _apiDataSource.fetchMessages(
            roomId: roomId,
            offset: params * pageSize,
            total: pageSize,
            type: roomType),
        params + 1);
  }
}
