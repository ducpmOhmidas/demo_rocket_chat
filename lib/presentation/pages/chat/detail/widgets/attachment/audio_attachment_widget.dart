import 'package:flutter/material.dart';
import 'package:flutter_application/design_system_widgets/app_loading_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../../blocs/message/message_bloc.dart';
import '../../../../../blocs/message/message_state.dart';


class AudioAttachmentWidget extends StatefulWidget {
  const AudioAttachmentWidget({Key? key, required this.audioUrl})
      : super(key: key);
  final String audioUrl;

  @override
  State<AudioAttachmentWidget> createState() => _AudioAttachmentWidgetState();
}

class _AudioAttachmentWidgetState extends State<AudioAttachmentWidget> with AutomaticKeepAliveClientMixin{
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.black12,
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(4),
      ),
      child: BlocBuilder<MessageBloc, MessageState>(builder: (context, state) {
        return state.mapOrNull((value) {
              switch (value.mediaStatus) {
                case MediaStatus.data:
                  return Row(
                    children: [
                      StreamBuilder<PlayerState>(
                        stream: value.audioController!.playerStateStream,
                        builder: (context, snapshot) {
                          final playerState = snapshot.data;
                          final processingState = playerState?.processingState;
                          final playing = playerState?.playing;
                          if (processingState == ProcessingState.loading ||
                              processingState == ProcessingState.buffering) {
                            return AppLoadingWidget();
                          } else if (playing != true) {
                            return IconButton(
                              icon: const Icon(Icons.play_arrow),
                              onPressed: value.audioController!.play,
                            );
                          } else if (processingState !=
                              ProcessingState.completed) {
                            return IconButton(
                              icon: const Icon(Icons.pause),
                              onPressed: value.audioController!.pause,
                            );
                          } else {
                            return IconButton(
                              icon: const Icon(Icons.replay),
                              onPressed: () =>
                                  value.audioController!.seek(Duration.zero),
                            );
                          }
                        },
                      ),
                      Expanded(
                        child: StreamBuilder<Duration>(
                          stream: value.audioController!.positionStream,
                          builder: (context, snapshot) {
                            final data = snapshot.data;
                            return Row(
                              children: [
                                Expanded(
                                  child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      inactiveTrackColor: Colors.black26,
                                      trackHeight: 2,
                                      thumbShape: RoundSliderThumbShape(
                                          enabledThumbRadius: 6),
                                      overlayShape:
                                          SliderComponentShape.noThumb,
                                    ),
                                    child: Slider(
                                      min: 0,
                                      max: value.audioController!.duration
                                              ?.inMilliseconds
                                              .toDouble() ??
                                          1,
                                      value:
                                          data?.inMilliseconds.toDouble() ?? 1,
                                      onChanged: (value) {},
                                      onChangeEnd: (value) {},
                                      activeColor: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                    '${(data?.inMinutes ?? 0) < 10 ? '0${data?.inMinutes ?? 0}' : data?.inMinutes}:${(data?.inSeconds ?? 0) < 10 ? '0${data?.inSeconds ?? 0}' : data?.inSeconds}'),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                default:
                  return Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.play_arrow),
                        onPressed: context.read<MessageBloc>().downloadAudio,
                      ),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            inactiveTrackColor: Colors.black26,
                            trackHeight: 2,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 6),
                            overlayShape: SliderComponentShape.noThumb,
                          ),
                          child: Slider(
                            min: 0,
                            max: 1,
                            value: 0,
                            // divisions: 1,
                            onChanged: (value) {},
                            onChangeEnd: (value) {},
                            activeColor: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  );
              }
            }) ??
            SizedBox();
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
