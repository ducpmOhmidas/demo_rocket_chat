import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/design_system_widgets/app_loading_widget.dart';
import 'package:flutter_application/presentation/blocs/message/message_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../../../blocs/message/message_bloc.dart';

class VideoAttachmentWidget extends StatefulWidget {
  const VideoAttachmentWidget({Key? key, required this.videoUrl})
      : super(key: key);
  final String videoUrl;

  @override
  State<VideoAttachmentWidget> createState() => _VideoAttachmentWidgetState();
}

class _VideoAttachmentWidgetState extends State<VideoAttachmentWidget> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<MessageBloc, MessageState>(builder: (context, state) {
      return state.mapOrNull((value) {
            switch (value.mediaStatus) {
              case MediaStatus.loading:
                return Container(
                  color: Colors.black,
                  width: double.infinity,
                  height: 160,
                  child: AppLoadingWidget(),
                );
              case MediaStatus.data:
                return SizedBox(
                  width: double.infinity,
                  height: 160,
                  child: AspectRatio(
                    aspectRatio: value.videoController!.value.aspectRatio,
                      child: Chewie(controller: value.chewieController!)),
                );
              default:
                return InkWell(
                  onTap: () async {
                    await context.read<MessageBloc>().downloadVideo();
                  },
                  child: Container(
                    color: Colors.black,
                    width: double.infinity,
                    height: 160,
                    child: Center(
                      child: Icon(
                        Icons.play_circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
            }
          }) ??
          SizedBox();
    });
  }

  @override
  bool get wantKeepAlive => true;
}
