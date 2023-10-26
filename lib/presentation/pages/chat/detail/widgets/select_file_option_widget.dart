import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class SelectFileOptionWidget extends StatelessWidget {
  const SelectFileOptionWidget({Key? key, required this.pickFileOptions})
      : super(key: key);
  final List<Tuple3<IconData, String, Function()>> pickFileOptions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: pickFileOptions
          .map((e) => FileOptionWidget(
                iconData: e.item1,
                title: e.item2,
                onTap: e.item3,
              ))
          .toList(),
    );
  }
}

class FileOptionWidget extends StatelessWidget {
  const FileOptionWidget(
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
