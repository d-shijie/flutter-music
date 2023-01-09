import 'package:flutter/material.dart';

class APPDrawer extends StatefulWidget {
  const APPDrawer({Key? key}) : super(key: key);

  @override
  State<APPDrawer> createState() => _APPDrawerState();
}

class _APPDrawerState extends State<APPDrawer> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('App Drawer'),
    );
  }
}
