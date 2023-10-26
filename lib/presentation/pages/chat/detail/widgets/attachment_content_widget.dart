import 'package:flutter/material.dart';
import 'package:flutter_application/design_system_widgets/image/app_image_widget.dart';
import 'package:flutter_application/presentation/blocs/message/message_bloc.dart';
import 'package:flutter_application/presentation/pages/chat/detail/widgets/audio_attachment_widget.dart';
import 'package:flutter_application/presentation/pages/chat/detail/widgets/video_attachment_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/message_entity.dart';
import 'file_attachment_widget.dart';

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
            FileAttachmentWidget(),
            Text(file.fileDescription ?? ''),
          ],
        );
      case AttachmentStatus.image:
        final file = item.attachments!.first;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(file.fileDescription ?? ''),
            SizedBox(
              width: double.infinity,
              height: 160,
              child: AppImageWidget(
                url: item.attachments!.first.imageUrl!,
                width: double.infinity,
                height: double.infinity,
              ),
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
