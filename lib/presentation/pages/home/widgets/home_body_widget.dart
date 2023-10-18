import 'package:flutter/material.dart';
import 'package:flutter_application/presentation/pages/forms/forms_page.dart';

class HomeBodyWidget extends StatefulWidget {
  const HomeBodyWidget({Key? key, required this.defaultData}) : super(key: key);
  final String defaultData;

  @override
  HomeBodyWidgetState createState() => HomeBodyWidgetState();
}

class HomeBodyWidgetState extends State<HomeBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.defaultData),
          ElevatedButton(onPressed: () {
            Navigator.pushNamed(context, FormsPage.path);
          }, child: Text('Forms')),
        ],
      ),
    );
  }
}
