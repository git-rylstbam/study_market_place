import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tolyui_navigation/tolyui_navigation.dart';

import '../../../extensions/get_extension.dart';
import '../model/home_model.dart';

/// CreateDate: 2025/7/9 17:44
/// Author: Lee
/// Description:

class LFOmitMenu extends StatelessWidget {
  const LFOmitMenu({
    super.key,
    required this.builder,
    this.controller,
    required this.routes,
    required this.navQuantity,
  });

  final TolyPopoverChildBuilder builder;
  final PopoverController? controller;
  final List<MenuRouter> routes;
  final int navQuantity;

  @override
  Widget build(BuildContext context) {
    const lightStyle = DropMenuCellStyle(
      backgroundColor: Colors.transparent,
      disableColor: Color(0xFFBFBFBF),
      foregroundColor: Color(0xFF1F1F1F),
      hoverForegroundColor: Color(0xFF1F1F1F),
      hoverBackgroundColor: Color(0xFFF5F5F5),
    );
    return Align(
      alignment: Alignment.centerLeft,
      child: TolyDropMenu(
        controller: controller,
        onSelect: onSelect,
        style: lightStyle,
        subMenuGap: 6.0,
        maxHeight: 400.0,
        placement: Placement.bottomStart,
        decorationConfig: const DecorationConfig(
          isBubble: false,
          backgroundColor: Colors.white,
        ),
        offsetCalculator: boxOffsetCalculator,
        menuItems: _children,
        onClose: () => enableIframeInteraction(),
        childBuilder: builder,
      ),
    );
  }

  void onSelect(MenuMeta menu) {
    final MenuDisplayExt? ext = menu.ext?.me<MenuDisplayExt>();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Get.lfOffNamedUntil(
        '/${menu.route}',
        parameters: ext?.meta?.toJson().map(
          (key, value) => MapEntry(key, value.toString()),
        ),
      ),
    );
  }

  List<MenuDisplay> get _children =>
      routes.skip(navQuantity).map<MenuDisplay>((route) {
        final menuMeta = MenuMeta(
          route: route.path ?? '',
          label: route.meta?.title ?? '',
          ext: MenuDisplayExt(meta: route.meta),
        );
        if (route.children.isNotEmpty) {
          return SubMenu(
            menuMeta,
            menus: route.children
                .map<MenuDisplay>(
                  (e) => ActionMenu(
                    MenuMeta(
                      label: e.meta?.title ?? '未知',
                      route: e.path ?? '',
                      ext: MenuDisplayExt(meta: e.meta),
                    ),
                  ),
                )
                .toList(),
          );
        } else {
          return ActionMenu(menuMeta);
        }
      }).toList();
}

class MenuDisplayExt extends Extra {
  const MenuDisplayExt({
    this.id,
    this.path,
    this.name,
    this.hidden,
    this.redirect,
    this.internationalName,
    this.component,
    this.alwaysShow,
    this.meta,
    this.children,
  });

  final String? path;
  final int? id;
  final String? name;
  final bool? hidden;
  final String? redirect;
  final String? internationalName;
  final String? component;
  final bool? alwaysShow;
  final MenuRouterMeta? meta;
  final List<MenuRouterChild>? children;

  String? get defaultPath {
    final temp = children?.firstOrNull?.path ?? path;
    return temp == null ? null : '/$temp';
  }
}

/// 关闭iframe点击(用于弹窗期间)
void disableIframeInteraction() {
  final elements = html.document.querySelectorAll('flt-platform-view');
  for (final e in elements) {
    e.style.pointerEvents = 'none';
  }
}

/// 回复iframe点击(弹窗关闭后)
void enableIframeInteraction() {
  final elements = html.document.querySelectorAll('flt-platform-view');
  for (final e in elements) {
    e.style.pointerEvents = 'auto';
  }
}
