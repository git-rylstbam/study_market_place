import '../../pages/login/api/i_login_api.dart';
import '../pages/home/api/i_home_api.dart';
import '../pages/market/api/i_market_api.dart';
import 'http_manager.dart';

/// CreateDate: 2025/7/8 16:07
/// Author: Lee
/// Description:

abstract class Http {
  static final _httpManager = HttpManager();

  static ILoginApi getLoginApi() => ILoginApi(_httpManager.dio);

  static IHomeApi getHomeApi() => IHomeApi(_httpManager.dio);

  static IMarketApi getMarketApi() => IMarketApi(_httpManager.dio);
}
