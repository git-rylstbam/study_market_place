import 'package:flutter/material.dart';

import '../../widgets/lf_cube_page.dart';

/// CreateDate: 2025/7/11 15:45
/// Author: Lee
/// Description:

class DashboardPage extends LFCubePage {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with LFCubePageState<DashboardPage> {
  @override
  String get path => 'analysis';

  @override
  String get title => 'Dashbaord';
}
