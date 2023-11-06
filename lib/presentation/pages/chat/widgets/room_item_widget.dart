import 'package:flutter/material.dart';
import 'package:flutter_application/design_system_widgets/image/app_image_widget.dart';
import 'package:flutter_application/domain/entities/room_entity.dart';
import 'package:flutter_application/presentation/blocs/room/room_bloc.dart';
import 'package:flutter_application/presentation/pages/chat/detail/chat_detail_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomItemWidget extends StatelessWidget {
  const RoomItemWidget({Key? key, required this.item}) : super(key: key);
  final RoomEntity item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final isGranted = await context.read<RoomBloc>().checkNavDetail();
        if (isGranted) {
          Navigator.pushNamed(context, ChatDetailPage.path, arguments: item);
        }
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AppImageWidget(
              url: '/avatar/${item.name}?format=png',
              width: 40,
              height: 40,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(item.updatedAt ?? '',
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                item.lastMsg != null
                    ? Text(
                        '${item.lastMsg?.userInfor?.name}: ${item.lastMsg?.msg}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    : Text('No message',
                        style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
