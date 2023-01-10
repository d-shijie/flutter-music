// ignore_for_file: must_be_immutable, avoid_print

import 'package:flutter/material.dart';

class ModalFit extends StatelessWidget {
  List items = [];
  Function onTap;
  ModalFit({Key? key, required this.items, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items
            .map((e) => ListTile(
                  leading: e['icon'],
                  title: Text(e['text']),
                  onTap: () {
                    onTap(e);
                  },
                ))
            .toList(),
      ),
    ));
  }
}
