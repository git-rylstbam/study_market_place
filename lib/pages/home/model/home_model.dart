import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

/// CreateDate: 2025/7/9 15:44
/// Author: Lee
/// Description:

part 'home_model.g.dart';

abstract class BaseMenuRouter {
  const BaseMenuRouter({
    this.path,
    this.id,
    this.name,
    this.hidden,
    this.internationalName,
    this.component,
    this.meta,
  });

  final String? path;
  final int? id;
  final String? name;
  final bool? hidden;
  final String? internationalName;
  final String? component;
  final MenuRouterMeta? meta;
}

@JsonSerializable()
class MenuRouterMeta {
  const MenuRouterMeta({this.title, this.icon, this.noCache, this.link});

  factory MenuRouterMeta.fromJson(Map<String, dynamic> json) =>
      _$MenuRouterMetaFromJson(json);

  final String? title;
  final String? icon;
  final bool? noCache;
  final String? link;

  Map<String, dynamic> toJson() => _$MenuRouterMetaToJson(this);

  @override
  String toString() => jsonEncode(this);
}

@JsonSerializable()
class MenuRouter extends BaseMenuRouter {
  const MenuRouter({
    super.path,
    super.id,
    super.name,
    super.hidden,
    super.internationalName,
    super.component,
    super.meta,
    this.redirect,
    this.alwaysShow,
    required this.children,
  });

  factory MenuRouter.fromJson(Map<String, dynamic> json) =>
      _$MenuRouterFromJson(json);

  final String? redirect;
  final bool? alwaysShow;
  final List<MenuRouterChild> children;

  String? get defaultPath {
    final temp = children.firstOrNull?.path ?? path;
    return temp == null ? null : '/$temp';
  }

  Map<String, dynamic> toJson() => _$MenuRouterToJson(this);

  @override
  String toString() => jsonEncode(this);
}

@JsonSerializable()
class MenuRouterChild extends BaseMenuRouter {
  const MenuRouterChild({
    super.path,
    super.id,
    super.name,
    super.hidden,
    super.internationalName,
    super.component,
    super.meta,
    this.perms,
  });

  factory MenuRouterChild.fromJson(Map<String, dynamic> json) =>
      _$MenuRouterChildFromJson(json);

  final String? perms;

  Map<String, dynamic> toJson() => _$MenuRouterChildToJson(this);

  @override
  String toString() => jsonEncode(this);
}
