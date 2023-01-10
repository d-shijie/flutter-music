// ignore_for_file: must_be_immutable, avoid_print

import 'dart:ffi';

import 'package:flutter/material.dart';

class DTitle extends StatefulWidget {
  String text = '';
  IconData? prefix;
  IconData? suffix;
  double? iconSize = 18;
  double? fontSize = 12;
  GestureTapCallback? onTap;
  DTitle(
      {Key? key,
      required this.text,
      this.prefix,
      this.suffix,
      this.iconSize,
      this.fontSize,
      this.onTap})
      : super(key: key);

  @override
  State<DTitle> createState() => _DTitleState();
}

class _DTitleState extends State<DTitle> {
  @override
  Widget build(BuildContext context) {
    bool notShowPre = widget.prefix != null ? false : true;
    bool notShowSuf = widget.suffix != null ? false : true;
    return Container(
      margin: const EdgeInsets.only(left: 15, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Visibility(保存状态)与Offstage(重新加载)都可以控制显示与隐藏
              Offstage(
                offstage: notShowPre,
                child: Icon(
                  widget.prefix,
                  size: widget.iconSize,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: Text(
                  widget.text,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: widget.fontSize),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Offstage(
                offstage: notShowSuf,
                child: Icon(
                  widget.suffix,
                  size: widget.iconSize,
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: InkWell(
              onTap: widget.onTap,
              child: Icon(
                Icons.more_vert,
                size: widget.iconSize,
              ),
            ),
          )
        ],
      ),
    );
  }
}
