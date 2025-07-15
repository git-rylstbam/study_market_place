import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/cube/page.dart';
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

  static const cube_dashboard = '/SIM_Dashboard';
  static const cube_sim = '/SIM_sim';
  static const cube_sms = '/SIM_SMS';
  static const cube_cdr = '/SIM_CDR';

  static const market = '/MarketP_Market';

  static final routes = [
    GetPage(name: cube_dashboard, page: () => const DashboardPage()),
    GetPage(name: market, page: () => const MarketPage()),
    GetPage(name: cube_sim, page: () => const SimPage()),
    GetPage(name: cube_sms, page: () => const SmsPage()),
    GetPage(name: cube_cdr, page: () => const CdrPage()),
  ];

  static final loadingPage = GetPage(
    name: loading,
    page: () => const Center(child: CircularProgressIndicator()),
  );

  static final errorPage = GetPage(name: error, page: () => const ErrorPage());
}
