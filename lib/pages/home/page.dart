import 'package:flutter/material.dart';

import '../../core/app_service.dart';
import '../../core/configs.dart';
import '../../http/http.dart';
import '../../resources/colors.dart';
import '../../widgets/lf_popup_menu_button.dart';
import '../../widgets/lf_toast.dart';
import 'model/home_model.dart';
import 'widgets/lf_vertical_tabbar.dart';

/// CreateDate: 2025/7/4 16:03
/// Author: Lee
/// Description:

const _kTabPaddingEdgeVertical = 3.0;
const _kTabLabelPaddingEdgeHorizontal = 6.0;
const _kTabLabelBorderRadius = Radius.circular(22.0);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final _routersNotifier = ValueNotifier<List<RouterEntity>>([]);
  final _selectRouterNotifier = ValueNotifier<RouterEntity?>(null);

  final _selectChildNotifier = ValueNotifier<RouterChildEntity?>(null);

  late TabController _hTabController;
  late TabController _vTabController;

  @override
  void initState() {
    super.initState();
    _queryRoutes();
    _hTabController = TabController(length: 0, vsync: this);
    _vTabController = TabController(length: 0, vsync: this);
  }

  @override
  void dispose() {
    _routersNotifier.dispose();
    _selectRouterNotifier.dispose();
    _selectChildNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Column(children: [_header, _buildTopTabLayout()]));

  Widget get _header => SizedBox(
    height: 50.0,
    child: Material(
      color: MyColors.headerColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 9.0, bottom: 9.0),
              child: Text(EnvConfig.logoName, style: TextStyle(fontSize: 24.0)),
            ),
            _trailing,
          ],
        ),
      ),
    ),
  );

  Widget get _trailing => LFPopupMenuButton(
    text: 'Hi, ${AppService.to.username}',
    icon: const Icon(Icons.logout_outlined),
    itemBuilder: (_) => _UserMenuEnum.values
        .map((e) => PopupMenuItem(value: e, child: Text(e.show)))
        .toList(),
    onSelected: (value) => switch (value) {
      _UserMenuEnum.edit_profile => LFToast.toast(context, value.show),
      _ => AppService.to.logout(),
    },
  );

  Widget _buildTopTabLayout() => Expanded(
    child: ListenableBuilder(
      listenable: Listenable.merge([_routersNotifier, _selectRouterNotifier]),
      builder: (_, __) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRect(
            child: AnimatedAlign(
              alignment: Alignment.topLeft,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              heightFactor: _routersNotifier.value.isEmpty ? .0 : 1.0,
              child: _routersNotifier.value.isEmpty
                  ? null
                  : Container(
                      width: double.infinity,
                      height: 40.0,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: MyColors.defaultColor),
                        ),
                      ),
                      child: _buildTopTabBar(_routersNotifier.value),
                    ),
            ),
          ),
          Expanded(child: _buildLeftTabLayout(_selectRouterNotifier.value)),
        ],
      ),
    ),
  );

  Widget _buildTopTabBar(List<RouterEntity> value) => ScrollConfiguration(
    behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
    child: TabBar(
      tabAlignment: TabAlignment.start,
      splashBorderRadius: const BorderRadius.all(_kTabLabelBorderRadius),
      controller: _hTabController,
      padding: const EdgeInsets.only(
        left: 46.0,
        top: _kTabPaddingEdgeVertical,
        right: 5.0,
        bottom: _kTabPaddingEdgeVertical,
      ),
      labelPadding: const EdgeInsets.symmetric(
        horizontal: _kTabLabelPaddingEdgeHorizontal,
        vertical: 8.0 - _kTabPaddingEdgeVertical,
      ),
      overlayColor: const WidgetStatePropertyAll(MyColors.defaultColor),
      labelColor: Colors.white,
      indicatorWeight: .0,
      indicator: _TopMenuIndicator(),
      isScrollable: true,
      tabs: value
          .map(
            (e) => Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
              child: Text(
                e.meta?.title ?? '未知',
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  height: 1.0,
                ),
              ),
            ),
          )
          .toList(),
      onTap: (index) {
        _selectRouterNotifier.value = value[index];
        _selectChildNotifier.value = value[index].children?[0];
        _vTabController = TabController(
          length: _selectRouterNotifier.value?.children?.length ?? 0,
          vsync: this,
        );
      },
    ),
  );

  Widget _buildLeftTabLayout(RouterEntity? value) => Row(
    children: [
      ClipRect(
        child: AnimatedAlign(
          alignment: Alignment.centerLeft,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          widthFactor: 1.0,
          child: value?.children == null || value!.children!.isEmpty
              ? null
              : Container(
                  width: 186.0,
                  padding: const EdgeInsets.fromLTRB(50.0, 30.0, 10.0, 30.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(color: MyColors.defaultColor),
                    ),
                  ),
                  child: _buildLeftTabBar(value),
                ),
        ),
      ),
      Expanded(
        child: ValueListenableBuilder(
          valueListenable: _selectChildNotifier,
          builder: (_, value, __) => Center(
            child: Text(
              value?.meta?.title ?? '未知',
              style: const TextStyle(
                fontSize: 120.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    ],
  );

  Widget _buildLeftTabBar(RouterEntity? value) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        value?.meta?.title ?? '--',
        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
      LFVerticalTabBar(
        controller: _vTabController,
        tabs:
            value?.children
                ?.map(
                  (e) => Container(
                    padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      e.meta?.title ?? '--',
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ),
                )
                .toList() ??
            [],
        onTap: (index) => _selectChildNotifier.value = value?.children?[index],
      ),
    ],
  );

  Future<void> _queryRoutes() async {
    final value = await Http.getHomeApi().queryRouters();
    if (value.isFaield) return;
    if (value.data == null || value.data!.isEmpty) return;
    _routersNotifier.value = value.data!;
    _hTabController = TabController(length: value.data!.length, vsync: this);
  }
}

class _TopMenuIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) =>
      const _TopMenuIndicatorPainter();
}

class _TopMenuIndicatorPainter extends BoxPainter {
  const _TopMenuIndicatorPainter();

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final aOffset = Offset(
      offset.dx - _kTabLabelPaddingEdgeHorizontal,
      offset.dy + _kTabPaddingEdgeVertical,
    );
    final aSize = Size(
      configuration.size!.width + _kTabLabelPaddingEdgeHorizontal * 2.0,
      configuration.size!.height - _kTabPaddingEdgeVertical * 2.0,
    );
    final rect = aOffset & aSize;
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = MyColors.defaultColor;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, _kTabLabelBorderRadius),
      paint,
    );
  }
}

enum _UserMenuEnum {
  edit_profile('Edit Profile'),
  logout('Logout');

  const _UserMenuEnum(this.show);

  final String show;
}
