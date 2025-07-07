import 'package:dio/dio.dart';

/// CreateDate: 2025/7/7 11:30
/// Author: Lee
/// Description:

class HeaderInterceptor extends InterceptorsWrapper {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.connectTimeout ??= const Duration(seconds: 30);
    options.receiveTimeout ??= const Duration(seconds: 60);
    if (options.data != null) {
      options.sendTimeout ??= const Duration(seconds: 60);
    }
    options.headers
      ..putIfAbsent('Content-Type', () => 'application/json')
      ..putIfAbsent('Authorization', () => '')
      ..putIfAbsent('Accept-Language', () => '');
    return super.onRequest(options, handler);
  }
}
