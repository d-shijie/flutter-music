// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Find extends StatefulWidget {
  const Find({Key? key}) : super(key: key);

  @override
  State<Find> createState() => _FindState();
}

class _FindState extends State<Find> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Find',
          style: TextStyle(fontSize: 20, color: Colors.red),
        ),
      ),
    );
  }
}
