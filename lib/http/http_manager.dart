import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../core/target_config/target.dart';
import 'interceptors/header_interceptors.dart';
import 'interceptors/log_interceptors.dart';
import 'interceptors/response_interceptors.dart';

/// CreateDate: 2025/7/8 16:14
/// Author: Lee
/// Description:

class HttpManager {
  factory HttpManager() => _instance;

  HttpManager._internal() {
    _dio.interceptors.add(_headerInterceptors);
    if (kDebugMode) {
      _dio.interceptors.add(_logInterceptors);
    }
    _dio.interceptors.add(ResponseInterceptors());
    _dio.options.baseUrl = LFConfigs().baseUrl;
  }

  static final HttpManager _instance = HttpManager._internal();

  final _headerInterceptors = HeaderInterceptors();
  final _logInterceptors = LogInterceptors();

  final _dio = Dio()..options.responseType = ResponseType.json;
  Dio? _downloadDIo;

  Dio get dio {
    if (!_dio.interceptors.contains(_logInterceptors)) {
      _dio.interceptors.add(_logInterceptors);
    }
    return _dio;
  }

  Dio get downloadDio {
    _downloadDIo ??= Dio()
      ..options.baseUrl = LFConfigs().baseUrl
      ..interceptors.add(_logInterceptors)
      ..interceptors.add(_headerInterceptors)
      ..options.responseType = ResponseType.bytes;
    return _downloadDIo!;
  }
}
