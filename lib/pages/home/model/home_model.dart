import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

/// CreateDate: 2025/7/9 15:44
/// Author: Lee
/// Description:

part 'home_model.g.dart';

abstract class BaseRouterEntity {
  const BaseRouterEntity({
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
  final RouterMetaEntity? meta;
}

@JsonSerializable()
class RouterMetaEntity {
  const RouterMetaEntity({this.title, this.icon, this.noCache, this.link});

  factory RouterMetaEntity.fromJson(Map<String, dynamic> json) =>
      _$RouterMetaEntityFromJson(json);

  final String? title;
  final String? icon;
  final bool? noCache;
  final String? link;

  Map<String, dynamic> toJson() => _$RouterMetaEntityToJson(this);

  @override
  String toString() => jsonEncode(this);
}

@JsonSerializable()
class RouterEntity extends BaseRouterEntity {
  const RouterEntity({
    super.path,
    super.id,
    super.name,
    super.hidden,
    super.internationalName,
    super.component,
    super.meta,
    this.redirect,
    this.alwaysShow,
     this.children,
  });

  factory RouterEntity.fromJson(Map<String, dynamic> json) =>
      _$RouterEntityFromJson(json);

  final String? redirect;
  final bool? alwaysShow;
  final List<RouterChildEntity>? children;

  String? get defaultPath {
    final temp = children?.firstOrNull?.path ?? path;
    return temp == null ? null : '/$temp';
  }

  Map<String, dynamic> toJson() => _$RouterEntityToJson(this);

  @override
  String toString() => jsonEncode(this);
}

@JsonSerializable()
class RouterChildEntity extends BaseRouterEntity {
  const RouterChildEntity({
    super.path,
    super.id,
    super.name,
    super.hidden,
    super.internationalName,
    super.component,
    super.meta,
    this.perms,
  });

  factory RouterChildEntity.fromJson(Map<String, dynamic> json) =>
      _$RouterChildEntityFromJson(json);

  final String? perms;

  Map<String, dynamic> toJson() => _$RouterChildEntityToJson(this);

  @override
  String toString() => jsonEncode(this);
}
