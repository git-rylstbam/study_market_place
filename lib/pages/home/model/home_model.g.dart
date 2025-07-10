// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuRouterMeta _$MenuRouterMetaFromJson(Map<String, dynamic> json) =>
    MenuRouterMeta(
      title: json['title'] as String?,
      icon: json['icon'] as String?,
      noCache: json['noCache'] as bool?,
      link: json['link'] as String?,
    );

Map<String, dynamic> _$MenuRouterMetaToJson(MenuRouterMeta instance) =>
    <String, dynamic>{
      'title': instance.title,
      'icon': instance.icon,
      'noCache': instance.noCache,
      'link': instance.link,
    };

MenuRouter _$MenuRouterFromJson(Map<String, dynamic> json) => MenuRouter(
      path: json['path'] as String?,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      hidden: json['hidden'] as bool?,
      internationalName: json['internationalName'] as String?,
      component: json['component'] as String?,
      meta: json['meta'] == null
          ? null
          : MenuRouterMeta.fromJson(json['meta'] as Map<String, dynamic>),
      redirect: json['redirect'] as String?,
      alwaysShow: json['alwaysShow'] as bool?,
      children: (json['children'] as List<dynamic>)
          .map((e) => MenuRouterChild.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MenuRouterToJson(MenuRouter instance) =>
    <String, dynamic>{
      'path': instance.path,
      'id': instance.id,
      'name': instance.name,
      'hidden': instance.hidden,
      'internationalName': instance.internationalName,
      'component': instance.component,
      'meta': instance.meta,
      'redirect': instance.redirect,
      'alwaysShow': instance.alwaysShow,
      'children': instance.children,
    };

MenuRouterChild _$MenuRouterChildFromJson(Map<String, dynamic> json) =>
    MenuRouterChild(
      path: json['path'] as String?,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      hidden: json['hidden'] as bool?,
      internationalName: json['internationalName'] as String?,
      component: json['component'] as String?,
      meta: json['meta'] == null
          ? null
          : MenuRouterMeta.fromJson(json['meta'] as Map<String, dynamic>),
      perms: json['perms'] as String?,
    );

Map<String, dynamic> _$MenuRouterChildToJson(MenuRouterChild instance) =>
    <String, dynamic>{
      'path': instance.path,
      'id': instance.id,
      'name': instance.name,
      'hidden': instance.hidden,
      'internationalName': instance.internationalName,
      'component': instance.component,
      'meta': instance.meta,
      'perms': instance.perms,
    };
