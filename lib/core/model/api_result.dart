import 'package:json_annotation/json_annotation.dart';

/// CreateDate: 2025/7/7 19:14
/// Author: Lee
/// Description:


abstract class ApiResultable {
  const ApiResultable();

  bool get isSuccess;

  bool get isFaield => !isSuccess;
}

abstract class LFApiResultable extends ApiResultable {
  const LFApiResultable({this.code, this.msg});

  final int? code;
  final String? msg;

  @override
  bool get isSuccess => code == ResultCode.success;
}

/// genericArgumentFactories: true
/// 告诉json_serializable库，当序列化或反序列化一个泛型类时，
/// 要为泛型类参数生成对应的工厂方法(即创建该泛型类型实例的代码)
@JsonSerializable(genericArgumentFactories: true)
