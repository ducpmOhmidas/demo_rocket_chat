import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'action_widget.dart';

class SelectActionWidget extends StatelessWidget {
  const SelectActionWidget(
      {Key? key, required this.pickFileOptions, this.height = 180})
      : super(key: key);
  final double height;
  final List<Tuple3<IconData, String, Function()>> pickFileOptions;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView(
        children: pickFileOptions
            .map((e) => ActionWidget(
                  iconData: e.item1,
                  title: e.item2,
                  onTap: e.item3,
                ))
            .toList(),
      ),
    );
  }
}
