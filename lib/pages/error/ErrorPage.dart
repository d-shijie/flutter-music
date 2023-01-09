// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  final String text;
  const ErrorPage({Key? key, required this.text}) : super(key: key);

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Text(
      widget.text,
      style: const TextStyle(
          fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
    )));
  }
}
