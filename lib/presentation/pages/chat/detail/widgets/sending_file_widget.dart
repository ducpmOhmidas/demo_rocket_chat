import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/design_system_widgets/form_field/app_text_form_field.dart';
import 'package:flutter_application/domain/entities/message_entity.dart';

import '../../../../blocs/chat/chat_state.dart';

class SendingFileWidget extends StatefulWidget {
  const SendingFileWidget(
      {Key? key,
      required this.roomName,
      required this.messageEntity,
      required this.onSend,
      required this.chatActionStatus, required this.onClose})
      : super(key: key);
  final String roomName;
  final MessageEntity messageEntity;
  final Function() onClose;
  final Function(String message) onSend;
  final ChatActionStatus chatActionStatus;

  @override
  State<SendingFileWidget> createState() => _SendingFileWidgetState();
}

class _SendingFileWidgetState extends State<SendingFileWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.9,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black87,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: widget.onClose,
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          )),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Sending to ${widget.roomName}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: LocalFileWidget(
                          messageEntity: widget.messageEntity,
                          chatActionStatus: widget.chatActionStatus),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AppTextFormField(
            textEditingController: _controller,
            hint: 'New message',
            suffix: IconButton(
              onPressed: () {
                widget.onSend(_controller.text);
              },
              icon: Icon(Icons.send),
            ),
            prefix: IconButton(
              onPressed: () {},
              icon: Icon(Icons.emoji_emotions_outlined),
            ),
          )
        ],
      ),
    );
  }
}

class LocalFileWidget extends StatelessWidget {
  const LocalFileWidget(
      {Key? key, required this.messageEntity, required this.chatActionStatus})
      : super(key: key);
  final MessageEntity messageEntity;
  final ChatActionStatus chatActionStatus;

  @override
  Widget build(BuildContext context) {
    log('chatActionStatus: $chatActionStatus');
    switch (chatActionStatus) {
      case ChatActionStatus.sendingImage:
        return Image.file(
          File(messageEntity.attachments!.first.imageUrl!),
          fit: BoxFit.cover,
        );
      default:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.attach_file, color: Colors.white,),
              const SizedBox(height: 4,),
              Text(messageEntity.attachments!.first.title ?? '', style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white),),
              const SizedBox(height: 4,),
              Text(messageEntity.attachments!.first.fileSize?.toString() ?? '', style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white),)
            ],
          ),
        );
    }
  }
}
