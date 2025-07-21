import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../extensions/get_extension.dart';
import '../pages/home/model/home_model.dart';
import '../pages/login/widgets/login_block.dart';
import '../routes.dart';
import '../util/storage.dart';
import 'keys.dart';
import 'model/user_info.dart';

/// CreateDate: 2025/7/7 13:38
/// Author: Lee
/// Description:

class AppService extends GetxController {
  static AppService get to => Get.find();

  StorageUtilCore get storage => StorageUtil.shared;

  bool get isLogin => token != null && token!.isNotEmpty && userInfo != null;

  String get username {
    if (userInfo == null) return '^_^';
    final user = userInfo?.user;
    if (user?.surname == null && user?.name == null) return '^_^';
    if (user?.surname == null) return user!.name!;
    if (user?.name == null) return user!.surname!;
    return '${user!.name!} ${user.surname!}';
  }

  String? get token => storage.read(Keys.key_token);

  UserInfo? _userInfo;

  UserInfo? get userInfo => _userInfo;

  List<RouterEntity>? _routers;

  List<RouterEntity>? get routers => _routers;

  set routers(List<RouterEntity>? routers) {
    _routers = routers;
    update([RouterIDEnum.routes]);
  }

  Locale? get locale => const Locale('en-US');

  Future<void> saveUserInfo(String token, UserInfo value) async {
    await storage.write(Keys.key_token, token);
    await storage.write(Keys.key_user_info, jsonEncode(value.toJson()));
    final user = await storage.read(Keys.key_user_info);
    final result = jsonDecode(user) as Map<String, dynamic>;
    _userInfo = UserInfo.fromJson(result);
  }

  Future<void> logout() async {
    await storage.remove(Keys.key_token);
    await storage.remove(Keys.key_user_info);
    _userInfo = null;
    Get.lfOffNamedUntil(Routes.login);
    // Globals.outNavigatorState.pushReplacementNamed(Routes.login);
  }
}
