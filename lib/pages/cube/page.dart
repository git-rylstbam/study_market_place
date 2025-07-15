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

class SimPage extends LFCubePage {
  const SimPage({super.key});

  @override
  State<SimPage> createState() => _SimPageState();
}

class _SimPageState extends State<SimPage> with LFCubePageState<SimPage> {
  @override
  String get path => 'simcard';

  @override
  String get title => 'Sim';
}

class SmsPage extends LFCubePage {
  const SmsPage({super.key});

  @override
  State<SmsPage> createState() => _SmsPageState();
}

class _SmsPageState extends State<SmsPage> with LFCubePageState<SmsPage> {
  @override
  String get path => 'message';

  @override
  String get title => 'Sms';
}

class CdrPage extends LFCubePage {
  const CdrPage({super.key});

  @override
  State<CdrPage> createState() => _CdrPageState();
}

class _CdrPageState extends State<CdrPage> with LFCubePageState<CdrPage> {
  @override
  String get path => 'cdrCard';

  @override
  String get title => 'Cdr';
}
