// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './utils/setting.dart';
import './pages/error/ErrorPage.dart';

import './route/routes.dart';

void main() {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();

  configLoading();
}

// 初始化loading
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2)
    ..indicatorType = EasyLoadingIndicatorType.wave
    ..loadingStyle = EasyLoadingStyle.dark //light dart custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow // 仅对custom类型有效
    ..backgroundColor = Colors.green // 仅对custom类型有效
    ..indicatorColor = Colors.yellow // 仅对custom类型有效
    ..textColor = Colors.yellow // 仅对custom类型有效
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  //如果应用程序想实现无 context 跳转，那么可以通过设置该key, 通过 navigatorKey.currentState.overlay.context 获取全局context。
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  //scaffoldMessengerKey 主要是管理后代的 Scaffolds，可以实现无 context 调用 snack bars
  //_scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("show SnackBar")));
  final GlobalKey<ScaffoldMessengerState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: _key,
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      theme: ThemeData(
          primarySwatch: Config.primarySwatchColor,
          primaryColor: Config.primaryColor),
      supportedLocales: const [Locale('zh', 'CH'), Locale('en', 'US')],
      routes: routes,
      initialRoute: '/',
      onGenerateRoute: (setting) {
        return MaterialPageRoute(
            builder: (context) => const ErrorPage(text: '404'));
      },
    );
  }
}
