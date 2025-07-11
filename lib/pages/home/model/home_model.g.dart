// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouterMetaEntity _$RouterMetaEntityFromJson(Map<String, dynamic> json) =>
    RouterMetaEntity(
      title: json['title'] as String?,
      icon: json['icon'] as String?,
      noCache: json['noCache'] as bool?,
      link: json['link'] as String?,
    );

Map<String, dynamic> _$RouterMetaEntityToJson(RouterMetaEntity instance) =>
    <String, dynamic>{
      'title': instance.title,
      'icon': instance.icon,
      'noCache': instance.noCache,
      'link': instance.link,
    };

RouterEntity _$RouterEntityFromJson(Map<String, dynamic> json) => RouterEntity(
      path: json['path'] as String?,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      hidden: json['hidden'] as bool?,
      internationalName: json['internationalName'] as String?,
      component: json['component'] as String?,
      meta: json['meta'] == null
          ? null
          : RouterMetaEntity.fromJson(json['meta'] as Map<String, dynamic>),
      redirect: json['redirect'] as String?,
      alwaysShow: json['alwaysShow'] as bool?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => RouterChildEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RouterEntityToJson(RouterEntity instance) =>
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

RouterChildEntity _$RouterChildEntityFromJson(Map<String, dynamic> json) =>
    RouterChildEntity(
      path: json['path'] as String?,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      hidden: json['hidden'] as bool?,
      internationalName: json['internationalName'] as String?,
      component: json['component'] as String?,
      meta: json['meta'] == null
          ? null
          : RouterMetaEntity.fromJson(json['meta'] as Map<String, dynamic>),
      perms: json['perms'] as String?,
    );

Map<String, dynamic> _$RouterChildEntityToJson(RouterChildEntity instance) =>
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
