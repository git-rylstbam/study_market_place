import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes.dart';
import '../util/storage.dart';
import 'keys.dart';
import 'model/user_info.dart';

/// CreateDate: 2025/7/7 13:38
/// Author: Lee
/// Description:

class AppService extends GetxController {
  StorageUtilCore get storage => StorageUtil.shared;

  String get username => '^_^';

  String? get token => storage.read(Keys.key_token);

  UserInfo? _userInfo;

  Locale? get locale => Get.locale;

  Future<void> removeUser() async {
    await storage.remove(Keys.key_token);
    await storage.remove(Keys.key_expired);
    _userInfo = null;
    await storage.remove(Keys.key_user_info);
    Get.offAllNamed(Routes.login);
  }
}
