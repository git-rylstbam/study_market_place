import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/app_service.dart';
import 'routes.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(AppService());
  runApp(const MyApp());
}

abstract class Globals {
  static GlobalKey<NavigatorState> key = GlobalKey();

  static NavigatorState get outNav => key.currentState!;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
    title: 'Study Market Place',
    debugShowCheckedModeBanner: false,
    theme: lightTheme,
    scrollBehavior: _MyScrollBehavior(),
    getPages: Routes.routes,
    initialRoute: Routes.login,
  );
}

class _MyScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
