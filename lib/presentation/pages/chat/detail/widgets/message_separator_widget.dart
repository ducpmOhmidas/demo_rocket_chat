import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageSeparatorWidget extends StatelessWidget {
  const MessageSeparatorWidget({Key? key, required this.date}) : super(key: key);
  final String date;

  @override
  Widget build(BuildContext context) {
    final formatter =  DateFormat('MMMM d, yyyy	');
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(children: [
        Expanded(child: Divider(height: 0,),),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(formatter.format(DateTime.parse(date))),
        ),
        Expanded(child: Divider(height: 0,),),
      ],),
      alignment: Alignment.center,
    );
  }
}