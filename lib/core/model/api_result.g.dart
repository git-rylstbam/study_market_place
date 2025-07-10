// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResult<T> _$ApiResultFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ApiResult<T>(
      code: (json['code'] as num?)?.toInt(),
      msg: json['msg'] as String?,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
    );

Map<String, dynamic> _$ApiResultToJson<T>(
  ApiResult<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

ApiListResult<T> _$ApiListResultFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ApiListResult<T>(
      code: (json['code'] as num?)?.toInt(),
      msg: json['msg'] as String?,
      total: (json['total'] as num?)?.toInt(),
      rows: (json['rows'] as List<dynamic>?)?.map(fromJsonT).toList(),
    );

Map<String, dynamic> _$ApiListResultToJson<T>(
  ApiListResult<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'total': instance.total,
      'rows': instance.rows?.map(toJsonT).toList(),
    };
