import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/model/api_result.dart';
import '../model/home_model.dart';

/// CreateDate: 2025/7/9 16:02
/// Author: Lee
/// Description:

part 'i_home_api.g.dart';

@RestApi()
abstract class IHomeApi {
  factory IHomeApi(Dio dio) = _IHomeApi;

  @GET('system/menu/getRouters')
  Future<ApiResult<List<MenuRouter>>> queryRouters();
}
