import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/model/api_result.dart';
import '../model/market_model.dart';

/// CreateDate: 2025/7/15 16:19
/// Author: Lee
/// Description:

part 'i_market_api.g.dart';

@RestApi()
abstract class IMarketApi {
  factory IMarketApi(Dio dio) = _IMarketApi;

  @GET('mp-core/marketplace/purchase/selectGoodsByCondition')
  Future<ApiListResult<MarketEntity>> queryMarketList({
    @Query('countries') List<String>? countries,
    @Query('region') String? region,
    @Query('simType') int? simType,
    @Query('pageNum') required int pageNum,
    @Query('pageSize') required int pageSize,
  });
}
