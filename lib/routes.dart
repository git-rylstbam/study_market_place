import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/home/page.dart';
import 'pages/login/page.dart';

/// CreateDate: 2025/7/4 16:02
/// Author: Lee
/// Description:

abstract class Routes {
  static const home = '/';

  static const loading = '/loading';
  static const error = '/error';

  static const login = '/login';

  static final routes = [
    GetPage(name: login, page: () => const LoginPage()),
    GetPage(name: home, page: () => const HomePage()),
  ];

  static final loadingPage = GetPage(
    name: loading,
    page: () => const Center(child: CircularProgressIndicator()),
  );
}
