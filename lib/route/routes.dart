// ignore_for_file: unused_import

import 'package:flutter/material.dart';

import '../pages/index/Index.dart';
import '../pages/find/index.dart';
import '../pages/profile/index.dart';

final routes = {
  '/': (context) => Index(
        pages: const [Find(), Profile(), Find(), Find()],
        items: const [
          {"label": '发现', "icon": Icon(Icons.policy_rounded)},
          {"label": '播客', "icon": Icon(Icons.mobile_friendly)},
          {"label": '我的', "icon": Icon(Icons.person)},
          {"label": '关注', "icon": Icon(Icons.follow_the_signs)}
        ],
        selectedItemColor: const Color.fromARGB(255, 217, 69, 58),
        unselectedItemColor: const Color.fromARGB(255, 83, 81, 81),
        selectedIconTheme: const IconThemeData(
            color: Color.fromARGB(255, 217, 69, 58), size: 20),
        unselectedIconTheme: const IconThemeData(
            color: Color.fromARGB(255, 83, 81, 81), size: 20),
        selectedLabelStyle: const TextStyle(color: Colors.blue),
        unselectedLabelStyle: const TextStyle(color: Colors.black),
      ),
  '/find': (context) => const Find(),
};
