import 'package:flutter/material.dart';

import '../../widgets/lf_outermost_shell.dart';

/// CreateDate: 2025/7/14 16:59
/// Author: Lee
/// Description:

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  @override
  Widget build(BuildContext context) => LFOutermostShell();
}
