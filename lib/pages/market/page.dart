import 'package:flutter/material.dart';

import '../../http/http.dart';
import '../../widgets/lf_outermost_shell.dart';
import 'model/market_model.dart';

/// CreateDate: 2025/7/14 16:59
/// Author: Lee
/// Description:

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  final _marketsNotifier = ValueNotifier<List<MarketEntity>>([]);

  @override
  void initState() {
    super.initState();
    _queryMarketList();
  }

  @override
  void dispose() {
    _marketsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      LFOutermostShell(child: Expanded(child: const SizedBox.shrink()));

  Future<void> _queryMarketList() async {
    final value = await Http.getMarketApi().queryMarketList(
      pageNum: 1,
      pageSize: 10,
    );
    if (value.isFaield) return;
    if (value.rows == null || value.rows!.isEmpty) return;
    _marketsNotifier.value = value.rows!;
  }
}
