import 'dart:typed_data';

import 'package:dio/dio.dart';

/// CreateDate: 2025/7/16 15:05
/// Author: Lee
/// Description:

class IFileApi {
  const IFileApi(this._dio);

  final Dio _dio;

  Future<Uint8List> queryFileByUrl(String url) async => _dio
      .get(
        'mp-core/marketplace/common/file/getFileByUrl',
        queryParameters: {'url': url},
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'noLoading': true},
        ),
      )
      .then((e) => e.data as Uint8List);
}
