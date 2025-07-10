import 'package:flutter/material.dart';

import '../model/home_model.dart';
import 'app_layout.dart';
import 'menu_router_state_mixin.dart';

/// CreateDate: 2025/7/9 15:39
/// Author: Lee
/// Description:

class MenuRouterLayout extends StatefulWidget {
  MenuRouterLayout({
    this.leading,
    this.middle,
    this.trailing,
    this.tabTrailing,
    this.fetchMenus,
    this.child,
    this.navQuantity,
  }) : super(key: stateKey);

  final Widget? leading;
  final Widget? middle;
  final Widget? trailing;
  final Widget? tabTrailing;
  final Future<List<MenuRouter>?> Function()? fetchMenus;
  final Widget? child;
  final int? navQuantity;

  static final stateKey = GlobalKey<MenuRouterLayoutState>();

  @override
  State<MenuRouterLayout> createState() => MenuRouterLayoutState();
}

class MenuRouterLayoutState extends State<MenuRouterLayout>
    with MenuRouterStateMixin {
  @override
  void initState() {
    super.initState();
    navQuantity ??= widget.navQuantity;
  }

  @override
  Future<List<MenuRouter>?> fetchMenus() =>
      widget.fetchMenus?.call() ?? super.fetchMenus();

  @override
  Widget build(BuildContext context) => MenuRoutesInherited(
    menuRoutes: routes,
    selectedMenu: selectedMenu,
    child: MyAppLayout(
      leading: widget.leading,
      middle: widget.middle,
      trailing: widget.trailing,
      tabTrailing: widget.tabTrailing,
      navQuantity: navQuantity ?? widget.navQuantity,
      currentLabel: currentLabel,
      child: widget.child,
    ),
  );
}

class MenuRoutesInherited extends InheritedModel<_MenuRouteEnum> {
  const MenuRoutesInherited({
    super.key,
    required this.menuRoutes,
    this.selectedMenu,
    required super.child,
  });

  static MenuRoutesInherited read(BuildContext context) =>
      context.getInheritedWidgetOfExactType<MenuRoutesInherited>()!;

  static MenuRoutesInherited of(BuildContext context) => _of(context);

  static MenuRoutesInherited _of(
    BuildContext context, [
    _MenuRouteEnum? type,
  ]) => InheritedModel.inheritFrom<MenuRoutesInherited>(context, aspect: type)!;

  static List<MenuRouter> menuRoutesOf(BuildContext context) =>
      _of(context, _MenuRouteEnum.menuRoutes).menuRoutes;

  static MenuRouter? selectedMenuOf(BuildContext context) =>
      _of(context, _MenuRouteEnum.selectedMenu).selectedMenu;

  final List<MenuRouter> menuRoutes;
  final MenuRouter? selectedMenu;

  @override
  bool updateShouldNotify(MenuRoutesInherited oldWidget) =>
      menuRoutes != oldWidget.menuRoutes ||
      selectedMenu != oldWidget.selectedMenu;

  @override
  bool updateShouldNotifyDependent(
    MenuRoutesInherited oldWidget,
    Set dependencies,
  ) => dependencies.any(
    (e) =>
        e is _MenuRouteEnum &&
        switch (e) {
          _MenuRouteEnum.menuRoutes => menuRoutes != oldWidget.menuRoutes,
          _MenuRouteEnum.selectedMenu => selectedMenu != oldWidget.selectedMenu,
        },
  );
}

enum _MenuRouteEnum { menuRoutes, selectedMenu }
