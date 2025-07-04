import '../configs.dart';

/// CreateDate: 2025/7/4 17:27
/// Author: Lee
/// Description:

abstract class MyConfigs {
  MyConfigs();

  String get baseOrigin => throw UnimplementedError();

  late final String baseUrl = '$baseOrigin/prod-api/';

  String get ossBaseUrl => throw UnimplementedError();

  String get webSocketBaseUrl => throw UnimplementedError();

  bool get debugTabFormJumpVerify => false;
}

class MpConfigs extends MyConfigs {
  @override
  String get baseOrigin => EnvConfig.isProd
      ? 'https://mppro.linksfield.net'
      : 'https://mpdemo.linksfield.net';

  @override
  String get webSocketBaseUrl => EnvConfig.isProd
      ? 'wss://dpapi.linksfield.net/'
      : 'wss://dppov2t.linksfield.net/';

  @override
  String get ossBaseUrl =>
      'https://lk-mp-${EnvConfig.isProd ? 'prod' : 'test'}.oss-cn-hongkong.aliyuncs.com/';
}
