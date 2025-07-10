import 'package:dio/dio.dart';

import '../../core/app_service.dart';

/// CreateDate: 2025/7/8 16:20
/// Author: Lee
/// Description:

class HeaderInterceptors extends InterceptorsWrapper {
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
      ..putIfAbsent('Authorization', () => AppService().token ?? '')
      ..putIfAbsent(
        'Accept-Language',
        () => AppService().locale?.toLanguageTag() ?? 'en-US',
      );
    return super.onRequest(options, handler);
  }
}
