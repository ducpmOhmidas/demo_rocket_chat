import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../design_system_widgets/app_loading_widget.dart';
import '../../../../blocs/message/message_bloc.dart';
import '../../../../blocs/message/message_state.dart';

class ImageAttachmentWidget extends StatefulWidget {
  static const path = '/image_attachment_widget';
  const ImageAttachmentWidget({Key? key, this.width = 54, this.height = 54})
      : super(key: key);
  final double width;
  final double height;

  @override
  State<ImageAttachmentWidget> createState() => _ImageAttachmentWidgetState();
}

class _ImageAttachmentWidgetState extends State<ImageAttachmentWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(builder: (context, state) {
      return state.mapOrNull((value) {
            switch (value.mediaStatus) {
              case MediaStatus.loading:
                return Container(
                  color: Colors.black,
                  width: widget.width,
                  height: widget.height,
                  child: AppLoadingWidget(),
                );
              case MediaStatus.data:
                return Image.file(
                  value.mediaFile!,
                  width: widget.width,
                  height: widget.height,
                  fit: BoxFit.cover,
                );
              default:
                return Container(
                  color: Colors.black,
                  width: widget.width,
                  height: widget.height,
                  child: AppLoadingWidget(),
                );
            }
          }) ??
          SizedBox();
    });
  }
}
