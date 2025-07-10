import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tolyui_navigation/tolyui_navigation.dart';

import '../../../extensions/get_extension.dart';
import '../../../resources/colors.dart';
import '../../../routes.dart';
import '../model/home_model.dart';
import 'app_header.dart';
import 'lf_layout_theme.dart';
import 'lf_omit_menu.dart';
import 'menu_router_layout.dart';
import 'tab_layout.dart';

/// CreateDate: 2025/7/9 15:33
/// Author: Lee
/// Description:

const _kTabPaddingEdgeVertical = 3.0;
const _kTabLabelPaddingEdgeHorizontal = 6.0;
const _kTabLabelBorderRadius = Radius.circular(22.0);

class MyAppLayout extends StatelessWidget {
  const MyAppLayout({
    super.key,
    this.leading,
    this.middle,
    this.trailing,
    this.tabTrailing,
    this.child,
    this.navQuantity,
    this.currentLabel,
  });

  final Widget? leading;
  final Widget? middle;
  final Widget? trailing;
  final Widget? tabTrailing;
  final Widget? child;
  final int? navQuantity;
  final String? currentLabel;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Builder(
          builder: (context) {
            final routes = MenuRoutesInherited.menuRoutesOf(context);
            final selectedMenu = MenuRoutesInherited.read(context).selectedMenu;
            return ClipRect(
              child: AnimatedAlign(
                alignment: Alignment.topLeft,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                heightFactor: routes.isEmpty ? 0 : 1,
                child: routes.isEmpty
                    ? null
                    : _MenuChild(
                        key: ValueKey(routes),
                        routes: routes,
                        selectedMenu: selectedMenu,
                        leading: leading,
                        middle: middle,
                        trailing: trailing,
                        tabTrailing: tabTrailing,
                        navQuantity: navQuantity,
                        currentLabel: currentLabel,
                      ),
              ),
            );
          },
        ),
        Expanded(child: MyTabLayout(child: child)),
      ],
    ),
  );
}

class _MenuChild extends StatefulWidget {
  const _MenuChild({
    super.key,
    required this.routes,
    this.selectedMenu,
    this.leading,
    this.middle,
    this.trailing,
    this.tabTrailing,
    this.navQuantity,
    this.currentLabel,
  });

  final List<MenuRouter> routes;
  final MenuRouter? selectedMenu;
  final Widget? leading;
  final Widget? middle;
  final Widget? trailing;
  final Widget? tabTrailing;
  final int? navQuantity;
  final String? currentLabel;

  @override
  State<_MenuChild> createState() => _MenuChildState();
}

class _MenuChildState extends State<_MenuChild>
    with SingleTickerProviderStateMixin {
  late TabController _hTabController;
  MenuRouterLayoutState? _menuRouterState;
  final PopoverController _menuController = PopoverController();

  @override
  void initState() {
    super.initState();
    final selected = widget.selectedMenu;
    final isOmitEnabled =
        widget.navQuantity != null &&
        widget.routes.length > widget.navQuantity!;
    final tabLength = isOmitEnabled
        ? widget.navQuantity! + 1
        : widget.routes.length;
    final initIndexTemp = selected == null
        ? 0
        : widget.routes.indexOf(selected);
    final initialIndex = isOmitEnabled
        ? (initIndexTemp > widget.navQuantity! - 1
              ? widget.navQuantity!
              : initIndexTemp)
        : initIndexTemp;
    _hTabController = TabController(
      initialIndex: initialIndex,
      length: tabLength,
      vsync: this,
    );
    if (_menuRouterState == null) {
      _menuRouterState = context
          .findAncestorStateOfType<MenuRouterLayoutState>();
      _menuRouterState?.hTabController = _hTabController;
    }
  }

  @override
  void didUpdateWidget(_MenuChild oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.routes != widget.routes) {
      final selected = widget.selectedMenu;
      final isOmitEnabled =
          widget.navQuantity != null &&
          widget.routes.length > widget.navQuantity!;
      final tabLength = isOmitEnabled
          ? widget.navQuantity! + 1
          : widget.routes.length;
      final initIndexTemp = selected == null
          ? 0
          : widget.routes.indexOf(selected);
      final initialIndex = isOmitEnabled
          ? (initIndexTemp > widget.navQuantity! - 1
                ? widget.navQuantity!
                : initIndexTemp)
          : initIndexTemp;
      _hTabController = TabController(
        initialIndex: initialIndex,
        length: tabLength,
        vsync: this,
      );
    }
  }

  @override
  void dispose() {
    _menuRouterState!.hTabController = null;
    _menuRouterState = null;
    _hTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final padding = LFLayoutTheme.of(context).mainViewPaddingWith(-14.0);
    final shouldOmit =
        widget.navQuantity != null &&
        widget.routes.length > widget.navQuantity!;
    final visibleRoutes = shouldOmit
        ? widget.routes.take(widget.navQuantity!)
        : widget.routes;
    Widget hMenuTabBar = TabBar(
      tabAlignment: TabAlignment.start,
      splashBorderRadius: const BorderRadius.all(_kTabLabelBorderRadius),
      controller: _hTabController,
      padding: EdgeInsets.only(
        left: padding,
        right: 5.0,
        top: _kTabPaddingEdgeVertical,
        bottom: _kTabPaddingEdgeVertical,
      ),
      labelPadding: const EdgeInsets.symmetric(
        horizontal: _kTabLabelPaddingEdgeHorizontal,
        vertical: 8.0 - _kTabPaddingEdgeVertical,
      ),
      overlayColor: theme.elevatedButtonTheme.style?.overlayColor,
      labelColor: Colors.white,
      indicatorWeight: .0,
      indicator: _MenuChildDecoration(),
      isScrollable: true,
      tabs: [
        for (final e in visibleRoutes) _buildMenuChild(e.meta?.title ?? '未知'),
        if (shouldOmit)
          MouseRegion(
            onEnter: (_) {
              _menuController.open();
              disableIframeInteraction();
            },
            child: LFOmitMenu(
              navQuantity: widget.navQuantity!,
              routes: widget.routes,
              controller: _menuController,
              builder: (_, __, ___) => widget.currentLabel != null
                  ? Text('${widget.currentLabel}')
                  : const Icon(Icons.more_horiz),
            ),
          ),
      ],
      onTap: (index) => WidgetsBinding.instance.addPostFrameCallback(
        (_) => Get.lfOffNamedUntil(
          widget.routes[index].defaultPath ?? Routes.error,
          parameters:
              (widget.routes[index].children.isNotEmpty
                      ? widget.routes[index].children.first.meta?.toJson()
                      : widget.routes[index].meta?.toJson())
                  ?.map((key, value) => MapEntry(key, value.toString())),
        ),
      ),
    );
    if (widget.tabTrailing != null) {
      hMenuTabBar = Row(
        children: [
          Expanded(child: hMenuTabBar),
          widget.tabTrailing!,
          SizedBox(width: padding),
        ],
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyAppHeader(
          leading: widget.leading,
          middle: widget.middle,
          trailing: widget.trailing,
        ),
        Container(
          width: double.infinity,
          height: 40.0,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: theme.dividerColor)),
          ),
          child: hMenuTabBar,
        ),
      ],
    );
  }

  Widget _buildMenuChild(String text) => Padding(
    padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        height: 1.0,
      ),
    ),
  );
}

class _MenuChildDecoration extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) =>
      const _MenuChildIndicatorPainter();
}

class _MenuChildIndicatorPainter extends BoxPainter {
  const _MenuChildIndicatorPainter();

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
