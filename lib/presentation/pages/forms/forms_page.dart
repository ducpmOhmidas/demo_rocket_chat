import 'package:flutter/material.dart';

class FormsPage extends StatefulWidget {
  static const path = '/forms_page';
  const FormsPage({Key? key}) : super(key: key);

  @override
  State<FormsPage> createState() => _FormsPageState();
}

class _FormsPageState extends State<FormsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forms Page'),
      ),
    );
  }
}
