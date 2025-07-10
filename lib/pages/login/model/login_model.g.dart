// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequestEntity _$LoginRequestEntityFromJson(Map<String, dynamic> json) =>
    LoginRequestEntity(
      username: json['username'] as String?,
      password: json['password'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$LoginRequestEntityToJson(LoginRequestEntity instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'code': instance.code,
    };

LoginEntity _$LoginEntityFromJson(Map<String, dynamic> json) => LoginEntity(
      access_token: json['access_token'] as String?,
      expires_in: (json['expires_in'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LoginEntityToJson(LoginEntity instance) =>
    <String, dynamic>{
      'access_token': instance.access_token,
      'expires_in': instance.expires_in,
    };
