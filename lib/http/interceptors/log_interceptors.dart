import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// CreateDate: 2025/7/8 17:42
/// Author: Lee
/// Description:

class LogInterceptors extends InterceptorsWrapper {
  @override
  Future<void> onRequest(RequestOptions options, handler) async {
    debugPrint('================ start request ================');
    debugPrint('=> ${options.baseUrl}${options.path} ${options.method}');
    if (options.queryParameters.isNotEmpty) {
      debugPrint('=> 请求参数: ${options.queryParameters}');
    }
    options.headers.forEach((key, value) {
      debugPrint('=> $key: $value');
    });
    if (options.data != null) {
      debugPrint('=> body: ${options.data}');
    }
    debugPrint('================ end request ================');
    return super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(Response response, handler) async {
    debugPrint('================ start response ================');
    debugPrint('<= ${response.statusCode} ${response.realUri}');
    debugPrint('<= 返回参数: $response');
    debugPrint('================ end response ================');
    return super.onResponse(response, handler);
  }

  @override
  Future<void> onError(DioException err, handler) async {
    debugPrint('================ start error ================');
    debugPrint('请求异常: $err');
    debugPrint('请求异常信息: ${err.response?.toString() ?? ''}');
    debugPrint('================ end error ================');
    super.onError(err, handler);
  }
}
