import 'package:flutter/material.dart';
import 'package:flutter_application/design_system_widgets/image/app_image_widget.dart';
import 'package:flutter_application/domain/entities/message_entity.dart';
import 'package:flutter_application/presentation/pages/chat/detail/widgets/attachment_content_widget.dart';

class MessageItemWidget extends StatefulWidget {
  const MessageItemWidget({Key? key, required this.item}) : super(key: key);
  final MessageEntity item;

  @override
  State<MessageItemWidget> createState() => _MessageItemWidgetState();
}

class _MessageItemWidgetState extends State<MessageItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppImageWidget(url: 'url'),
        const SizedBox(width: 16,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(widget.item.userInfor?.name ?? ''),
                  const SizedBox(width: 16,),
                  Text(widget.item.updatedAt ?? '', style: Theme.of(context).textTheme.bodySmall,)
                ],
              ),
              AttachmentContentWidget(item: widget.item),
              Text(widget.item.msg ?? '', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        )
      ],
    );
  }
}