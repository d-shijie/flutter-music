// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

class Index extends StatefulWidget {
  List pages = [];
  List items = [];
  double? selectedFontSize = 10.0;
  double? unselectedFontSize = 8.0;
  Color? selectedItemColor;
  Color? unselectedItemColor;
  IconThemeData? selectedIconTheme;
  IconThemeData? unselectedIconTheme;
  TextStyle? selectedLabelStyle;
  TextStyle? unselectedLabelStyle;
  Index({
    Key? key,
    required this.pages,
    required this.items,
    this.selectedFontSize,
    this.unselectedFontSize,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedIconTheme,
    this.unselectedIconTheme,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
  }) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        // 允许多个item
        type: BottomNavigationBarType.fixed,
        selectedFontSize: widget.selectedFontSize ?? 10,
        unselectedFontSize: widget.unselectedFontSize ?? 8,
        selectedItemColor: widget.selectedItemColor,
        unselectedItemColor: widget.unselectedItemColor,
        // 优先于 selectedItem
        selectedIconTheme: widget.selectedIconTheme,
        unselectedIconTheme: widget.unselectedIconTheme,
        // 设置theme时无效
        selectedLabelStyle: widget.selectedLabelStyle,
        unselectedLabelStyle: widget.unselectedLabelStyle,
        currentIndex: _currentIndex,
        items: widget.items
            .map((e) =>
                BottomNavigationBarItem(icon: e['icon'], label: e['label']))
            .toList(),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
