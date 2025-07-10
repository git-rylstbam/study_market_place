// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

/// CreateDate: 2025/7/8 16:00
/// Author: Lee
/// Description:

part 'login_model.g.dart';

@JsonSerializable()
class LoginRequestEntity {
  const LoginRequestEntity({this.username, this.password, this.code});

  factory LoginRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestEntityFromJson(json);

  final String? username;
  final String? password;
  final String? code;

  Map<String, dynamic> toJson() => _$LoginRequestEntityToJson(this);

  @override
  String toString() => jsonEncode(this);
}

@JsonSerializable()
class LoginEntity {
  const LoginEntity({this.access_token, this.expires_in});

  factory LoginEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginEntityFromJson(json);

  final String? access_token;
  final int? expires_in;

  Map<String, dynamic> toJson() => _$LoginEntityToJson(this);

  @override
  String toString() => jsonEncode(this);
}
