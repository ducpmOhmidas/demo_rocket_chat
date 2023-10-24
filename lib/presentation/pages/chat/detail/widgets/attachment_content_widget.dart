import 'package:flutter/material.dart';
import 'package:flutter_application/design_system_widgets/image/app_image_widget.dart';
import 'package:flutter_application/presentation/blocs/message/message_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Expanded(
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
            Expanded(
              child: context
                          .watch<MessageBloc>()
                          .state
                          .mapOrNull((value) => value.mediaLoading) ==
                      true
                  ? Container(
                      color: Colors.black,
                      child: Center(
                        child: Icon(
                          Icons.play_circle,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : AppImageWidget(
                      url: item.attachments!.first.videoUrl!,
                      width: double.infinity,
                      height: double.infinity,
                    ),
            ),
          ],
        );
      case AttachmentStatus.audio:
        return SizedBox();
      default:
        return SizedBox();
    }
  }
}
