import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/app_service.dart';
import 'pages/home/page.dart';
import 'pages/home/widgets/lf_overflow_box.dart';
import 'pages/login/page.dart';
import 'routes.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(AppService());
  runApp(const MyApp());
}

abstract class Globals {
  static GlobalKey<NavigatorState> outNavigatorKey = GlobalKey();

  static NavigatorState get outNavigatorState => outNavigatorKey.currentState!;
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
    initialRoute: Routes.cube_dashboard,
    transitionDuration: Duration.zero,
    defaultTransition: Transition.noTransition,
    unknownRoute: Routes.errorPage,
    builder: (context, child) => LFOverflowBox(
      minWidth: 1180.0,
      alignment: Alignment.centerLeft,
      child: Navigator(
        key: Globals.outNavigatorKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (_) => settings.name == Routes.login
              ? const LoginPage()
              : HomePage(child: child),
        ),
        onGenerateInitialRoutes: (_, __) => [
          MaterialPageRoute(
            builder: (_) => AppService.to.isLogin
                ? HomePage(child: child)
                : const LoginPage(),
          ),
        ],
      ),
    ),
  );
}

class _MyScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
