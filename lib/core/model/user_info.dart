import 'package:json_annotation/json_annotation.dart';

/// CreateDate: 2025/7/7 19:09
/// Author: Lee
/// Description:

class TokenEntity {
  const TokenEntity(this.token, this.expiredAt);

  TokenEntity.fromExpiredMinutes(this.token, int minutes)
    : expiredAt = DateTime.now().add(Duration(minutes: minutes - 1));

  final String token;
  final DateTime expiredAt;
}

@JsonSerializable()
class UserInfo
