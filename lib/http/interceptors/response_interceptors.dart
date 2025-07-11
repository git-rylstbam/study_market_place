import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/app_service.dart';
import '../../core/model/result_code.dart';

/// CreateDate: 2025/7/8 16:28
/// Author: Lee
/// Description:

class ResponseInterceptors extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data case {
      'code': final int code,
    } when code != ResultCode.success) {
      debugPrint(response.data['msg']);
      if (code == ResultCode.token_overdue) {
        AppService().logout();
      }
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.type == DioExceptionType.cancel) return;
    debugPrint(err.message);
    super.onError(err, handler);
  }
}
