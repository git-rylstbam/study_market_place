import 'package:get/get.dart';
import 'package:study_market_place/core/keys.dart';
import 'package:study_market_place/util/storage.dart';

/// CreateDate: 2025/7/7 13:38
/// Author: Lee
/// Description:

class AppService extends GetxController {
  StorageUtilCore get storage => StorageUtil.shared;

  String get username => '^_^';

  String? get token => storage.read(Keys.key_token);

  UserInfo? _userInfo;

}
