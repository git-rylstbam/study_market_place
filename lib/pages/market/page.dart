import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../http/http.dart';
import '../../widgets/lf_outermost_shell.dart';
import '../../widgets/lf_pagination.dart';
import 'model/market_model.dart';
import 'widgets/market_child.dart';

/// CreateDate: 2025/7/14 16:59
/// Author: Lee
/// Description:

const kItemSize = 300.0;
const kPaddingSize = 20.0;
const kPriceHeight = 25.0;
const kTitleHeight = kPriceHeight;
const kDividerHeight = 10.0;
const kImageHeight =
    kItemSize - kPaddingSize * 2 - kDividerHeight - kTitleHeight - kPriceHeight;

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  final _marketsNotifier = ValueNotifier<List<MarketEntity>>([]);
  final _totalNotifier = ValueNotifier<int>(0);
  final _pageNumNotifier = ValueNotifier<int>(1);

  @override
  void initState() {
    super.initState();
    _queryMarketList(_pageNumNotifier.value);
  }

  @override
  void dispose() {
    _marketsNotifier.dispose();
    _totalNotifier.dispose();
    _pageNumNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LFOutermostShell(
    title: '',
    footer: ListenableBuilder(
      listenable: Listenable.merge([_totalNotifier, _pageNumNotifier]),
      builder: (_, __) => LFPagination(
        total: _totalNotifier.value,
        pageNum: _pageNumNotifier.value,
        onSelected: (value) {
          _queryMarketList(value);
          _pageNumNotifier.value = value;
        },
      ),
    ),
    child: Expanded(
      child: Column(
        children: [
          const SizedBox(height: 25.0),
          ValueListenableBuilder(
            valueListenable: _marketsNotifier,
            builder: (_, value, __) => GridView(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              key: ValueKey(value),
              gridDelegate: const _SliverGridDelegateWithFixedCrossAxisExtent(
                childMainAxisExtent: kItemSize - kPriceHeight,
                childCrossAxisExtent: kItemSize,
                minCrossSpacing: 50.0,
                mainAxisSpacing: 12.0,
              ),
              children: value.map((e) => MarketChild(entity: e)).toList(),
            ),
          ),
        ],
      ),
    ),
  );

  Future<void> _queryMarketList(int pageNum) async {
    final value = await Http.getMarketApi().queryMarketList(
      pageNum: pageNum,
      pageSize: 10,
    );
    if (value.isFaield) return;
    if (value.rows == null || value.rows!.isEmpty) return;
    _marketsNotifier.value = value.rows!;
    _totalNotifier.value = value.total ?? 0;
  }
}

class _SliverGridDelegateWithFixedCrossAxisExtent extends SliverGridDelegate {
  const _SliverGridDelegateWithFixedCrossAxisExtent({
    required this.childMainAxisExtent,
    required this.childCrossAxisExtent,
    required this.minCrossSpacing,
    this.mainAxisSpacing = .0,
  });

  final double childMainAxisExtent;
  final double childCrossAxisExtent;
  final double minCrossSpacing;
  final double mainAxisSpacing;

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final int crossAxisCount =
        (constraints.crossAxisExtent + minCrossSpacing) ~/
        (childCrossAxisExtent + minCrossSpacing);
    final int fixedCrossAxisCount = crossAxisCount <= 0 ? 1 : crossAxisCount;
    final fixedMinCrossSpacing = fixedCrossAxisCount > 1.0
        ? ((constraints.crossAxisExtent -
                  (childCrossAxisExtent * fixedCrossAxisCount)) /
              (fixedCrossAxisCount - 1))
        : .0;
    return SliverGridRegularTileLayout(
      crossAxisCount: fixedCrossAxisCount,
      mainAxisStride: childMainAxisExtent + mainAxisSpacing,
      crossAxisStride: childCrossAxisExtent + fixedMinCrossSpacing,
      childMainAxisExtent: childMainAxisExtent,
      childCrossAxisExtent: childCrossAxisExtent,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(
    _SliverGridDelegateWithFixedCrossAxisExtent oldDelegate,
  ) =>
      childMainAxisExtent != oldDelegate.childMainAxisExtent ||
      mainAxisSpacing != oldDelegate.mainAxisSpacing ||
      minCrossSpacing != oldDelegate.minCrossSpacing ||
      mainAxisSpacing != oldDelegate.mainAxisSpacing;
}
