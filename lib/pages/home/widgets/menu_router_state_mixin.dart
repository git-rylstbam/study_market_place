import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../extensions/get_extension.dart';
import '../../../http/http.dart';
import '../../../routes.dart';
import '../../../widgets/lf_toast.dart';
import '../model/home_model.dart';

/// CreateDate: 2025/7/9 16:05
/// Author: Lee
/// Description:

mixin MenuRouterStateMixin<T extends StatefulWidget> on State<T> {
  TabController? _hTabController;

  TabController? get hTabController => _hTabController;

  TabController? _vTabController;

  TabController? get vTabController => _vTabController;

  int? navQuantity;
  String? currentLabel;

  set hTabController(TabController? value) => _hTabController = value;

  set vTabController(TabController? value) => _vTabController = value;

  List<MenuRouter>? _routes;

  List<MenuRouter> get routes => _routes ?? [];

  set routes(List<MenuRouter>? value) {
    setState(() => _routes = value);
    selectedMenu = value?.firstOrNull;
  }

  MenuRouter? _selectedMenu;

  MenuRouter? get selectedMenu => _selectedMenu;

  set selectedMenu(MenuRouter? value) {
    if (_selectedMenu == value) return;
    setState(() => _selectedMenu = value);
  }

  Future<List<MenuRouter>?> fetchMenus() async {
    final value = await Http.getHomeApi().queryRouters();
    if (value.isFaield) return null;
    return value.data;
  }

  Future<bool> queryMenu({
    String? defaultPath,
    List<MenuRouter>? visibleMenus,
  }) async {
    List<MenuRouter>? menus = await fetchMenus();
    if (menus == null) return false;
    if (menus.isEmpty) {
      LFToast.toast('登录失败，请联系管理员');
      return false;
    }
    if (visibleMenus != null && visibleMenus.isNotEmpty) {
      final visibleIds = visibleMenus.map((e) => e.id).toSet();
      final routerMap = {for (final e in menus) e.id: e};
      final visibleRouters = visibleIds
          .map((e) => routerMap[e])
          .whereType<MenuRouter>()
          .toList();
      final hiddenRouters = menus
          .where((e) => !visibleIds.contains(e.id))
          .toList();
      navQuantity = visibleRouters.length;
      menus = [...visibleRouters, ...hiddenRouters];
      final currentRoute = Get.currentRoute.split('?').first;
      _setRoutes(menus, currentRoute);
      if (currentRoute == Routes.loading || currentRoute == Routes.login) {
        Get.lfOffNamedUntil(routes.firstOrNull?.defaultPath ?? Routes.error);
      }
    }
    return true;
  }

  /// 设置当前路由
  void _setRoutes(List<MenuRouter>? value, [String? defaultPath]) {
    routes = value;
    if (_routes == null || _routes!.isEmpty) {
      selectedMenu = null;
    } else {
      int? firstIndexTemp;
      if (defaultPath != null) {
        final temp = _getCurrentPosition(_routes!, defaultPath);
        firstIndexTemp = temp.$1;
      }
      selectedMenu = _routes![firstIndexTemp ?? 0];
      if (firstIndexTemp != null &&
          navQuantity != null &&
          firstIndexTemp + 1 > navQuantity!) {
        currentLabel = selectedMenu?.meta?.title;
      }
    }
  }

  (int?, int?) _getCurrentPosition(List<MenuRouter> value, String defaultPath) {
    final key = defaultPath.substring(1).split('/').first;
    for (int i = 0; i < value.length; i++) {
      final parent = value[i];
      if (parent.children.isEmpty) {
        if (key == parent.path) {
          return (i, null);
        }
      } else {
        for (int j = 0; j < parent.children.length; j++) {
          final child = parent.children[j];
          if (key == child.path) {
            return (i, j);
          }
        }
      }
    }
    return (null, null);
  }
}
