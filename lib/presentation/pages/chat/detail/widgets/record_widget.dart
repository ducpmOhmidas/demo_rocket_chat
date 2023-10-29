import 'package:flutter/material.dart';
import 'package:flutter_application/presentation/blocs/chat/chat_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordWidget extends StatefulWidget {
  const RecordWidget({Key? key, required this.onClose, required this.onSend}) : super(key: key);
  final Function() onClose;
  final Function() onSend;

  @override
  State<RecordWidget> createState() => _RecordWidgetState();
}

class _RecordWidgetState extends State<RecordWidget> {
  
  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: widget.onClose, icon: Icon(Icons.restore_from_trash, color: Colors.red,),),
        const SizedBox(width: 8,),
        Text('${context.watch<ChatBloc>().state.mapOrNull((value) => value.recordProgressTimer)}'),
        const SizedBox(width: 8,),
        Icon(Icons.fiber_manual_record_rounded, color: Colors.red,),
        const Spacer(),
        IconButton(
          onPressed: widget.onSend,
          icon: Icon(Icons.send),
        )
      ],
    );
  }
}