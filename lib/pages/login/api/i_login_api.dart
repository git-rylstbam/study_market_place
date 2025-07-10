import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/model/api_result.dart';
import '../model/login_model.dart';

/// CreateDate: 2025/7/8 15:57
/// Author: Lee
/// Description:

part 'i_login_api.g.dart';

@RestApi()
abstract class ILoginApi {
  factory ILoginApi(Dio dio) = _ILoginApi;

  @POST('auth/login')
  Future<ApiResult<LoginEntity>> login(@Body() LoginRequestEntity body);
}
