import 'package:flutter/material.dart';

class ActionWidget extends StatelessWidget {
  const ActionWidget(
      {Key? key, required this.iconData, required this.title, this.onTap})
      : super(key: key);
  final IconData iconData;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black26))),
        child: Row(
          children: [
            Icon(iconData),
            const SizedBox(
              width: 8,
            ),
            Expanded(child: Text(title)),
          ],
        ),
      ),
    );
  }
}