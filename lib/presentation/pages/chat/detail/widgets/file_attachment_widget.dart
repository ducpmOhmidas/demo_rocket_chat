import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';

import '../../../../blocs/message/message_bloc.dart';
import '../../../../blocs/message/message_state.dart';

class FileAttachmentWidget extends StatefulWidget {
  const FileAttachmentWidget({Key? key}) : super(key: key);

  @override
  State<FileAttachmentWidget> createState() => _FileAttachmentWidgetState();
}

class _FileAttachmentWidgetState extends State<FileAttachmentWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(builder: (context, state) {
      final data = state.mapOrNull((value) => value.data.attachments?.first);
      return InkWell(
        onTap: () async {
          await context.read<MessageBloc>().openFile();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 8),
              decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.black45))),
              child: Text(data?.title ?? '',
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
            Container(
              padding: EdgeInsets.only(left: 8),
              decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.black45))),
              child: Text(data?.title ?? '',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400, color: Colors.black45)),
            ),
          ],
        ),
      );
    });
  }
}
