import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/dashboard/page.dart';
import 'pages/error_page.dart';
import 'pages/market/page.dart';

/// CreateDate: 2025/7/4 16:02
/// Author: Lee
/// Description:

abstract class Routes {
  static const home = '/';

  static const loading = '/loading';
  static const error = '/error';

  static const login = '/login';

  static const dashboard = '/SIM_Dashboard';

  static const market = '/MarketP_Market';

  static final routes = [
    GetPage(name: dashboard, page: () => const DashboardPage()),
    GetPage(name: market, page: () => const MarketPage()),
  ];

  static final loadingPage = GetPage(
    name: loading,
    page: () => const Center(child: CircularProgressIndicator()),
  );

  static final errorPage = GetPage(name: error, page: () => const ErrorPage());
}
