import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_market_place/routes.dart';
import 'package:study_market_place/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
    title: 'Study Market Place',
    debugShowCheckedModeBanner: false,
    theme: lightTheme,
    scrollBehavior: _MyScrollBehavior(),
    getPages: [Routes.loginPage, ...Routes.routes],
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
