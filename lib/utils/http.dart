// ignore_for_file: avoid_print, void_checks

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HttpUtils {
  static const String baseUrl = "http://10.17.70.98:3000";
  static Dio dio = Dio();
  // 基础配置
  HttpUtils() {
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: ((options, handler) => {
              handler.next(options),
              EasyLoading.show(status: '加载中...'),
            }),
        onResponse: ((response, handler) => {
              // 可通过handler返回自己处理的数据
              EasyLoading.dismiss(),
              handler.next(response),
            }),
        onError: ((e, hanlder) => {
              EasyLoading.show(status: '请求失败'),
              print(e),
            })));
  }
  // []代表可选 dynamic啥都行？
  Future get(String url, [Map<String, dynamic>? params]) async {
    try {
      Response response = await dio.get(url, queryParameters: params ?? {});
      return response.data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future post(String url, [Map<String, dynamic>? params]) {
    return dio.post(url, data: params ?? {});
  }

  // 需要token的请求
  Future postToken(String url, String token, [Map<String, dynamic>? params]) {
    Dio req = setToken(token);
    return req.post(url, data: params ?? {});
  }

  Future getToken(String url, String token, [Map<String, dynamic>? params]) {
    Dio req = setToken(token);
    return req.get(url, queryParameters: params ?? {});
  }

  setToken(String token) {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      headers: {
        // 自定义
        'x-nideshop-token': token,
      },
    );
    Dio req = Dio(options);
    // 添加拦截器
    req.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return; //continue
      },
      onResponse: (response, handler) {
        if (response.data['errno'] == 0) {
          return response.data['data'];
        } else {
          return;
        }
      },
      onError: (e, handler) {
        print(e);
        return; //continue
      },
    ));
    return req;
  }
}
