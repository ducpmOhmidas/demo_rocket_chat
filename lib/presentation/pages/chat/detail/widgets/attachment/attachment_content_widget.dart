import 'package:flutter/material.dart';

import '../../../../../../domain/entities/message_entity.dart';
import 'audio_attachment_widget.dart';
import 'file_attachment_widget.dart';
import 'image_attachment_widget.dart';
import 'video_attachment_widget.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(file.fileDescription ?? ''),
            FileAttachmentWidget(),
          ],
        );
      case AttachmentStatus.image:
        final file = item.attachments!.first;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(file.fileDescription ?? ''),
            Container(
              width: double.infinity,
              height: 160,
              color: Colors.red,
              child:  ImageAttachmentWidget(width: double.infinity, height: double.infinity,)
            )
          ],
        );
      case AttachmentStatus.video:
        final file = item.attachments!.first;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(file.fileDescription ?? ''),
            VideoAttachmentWidget(
              key: ValueKey(item.id),
                videoUrl: item.attachments!.first.videoUrl!),
          ],
        );
      case AttachmentStatus.audio:
        final file = item.attachments!.first;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(file.fileDescription ?? ''),
            AudioAttachmentWidget(audioUrl: item.attachments!.first.audioUrl!),
          ],
        );
      default:
        return SizedBox();
    }
  }
}
