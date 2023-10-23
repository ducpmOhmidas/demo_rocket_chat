import 'package:flutter/material.dart';
import 'package:flutter_application/design_system_widgets/image/app_image_widget.dart';

import '../../../../../domain/entities/message_entity.dart';

class AttachmentContentWidget extends StatelessWidget {
  const AttachmentContentWidget({Key? key, required this.item})
      : super(key: key);
  final MessageEntity item;

  @override
  Widget build(BuildContext context) {
    switch (item.attachmentStatus) {
      case AttachmentStatus.file:
        final file = item.attachments!.first;
        return Column(
          children: [
            Text(file.title ?? '',
                style: Theme.of(context).textTheme.bodyMedium),
            Text(
              file.title ?? '',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w400),
            ),
            Text(file.fileDescription ?? ''),
          ],
        );
      case AttachmentStatus.image:
        final file = item.attachments!.first;
        return Column(
          children: [
            Text(file.fileDescription ?? ''),
            AppImageWidget(
              url:
                  'https://chat.ohmidasvn.dev/file-upload/65363719955bcdac5fa261fb/IMG_0610.jpg',
              width: double.infinity,
              height: 160,
            )
          ],
        );
      case AttachmentStatus.video:
        return SizedBox();
      case AttachmentStatus.audio:
        return SizedBox();
      default:
        return SizedBox();
    }
  }
}
