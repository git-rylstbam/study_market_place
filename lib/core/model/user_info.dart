import 'package:json_annotation/json_annotation.dart';

import 'api_result.dart';

/// CreateDate: 2025/7/7 19:09
/// Author: Lee
/// Description:

part 'user_info.g.dart';

class TokenEntity {
  const TokenEntity(this.token, this.expiredAt);

  TokenEntity.fromExpiredMinutes(this.token, int minutes)
    : expiredAt = DateTime.now().add(Duration(minutes: minutes - 1));

  final String token;
  final DateTime expiredAt;
}

@JsonSerializable()
class UserInfo extends LFApiResultable {
  const UserInfo({
    super.code,
    super.msg,
    this.enterpriseType,
    required this.permissions,
    this.roles,
    this.user,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  UserInfo copyWith(User? user) => UserInfo(
    code: code,
    msg: msg,
    enterpriseType: enterpriseType,
    permissions: permissions,
    roles: roles,
    user: user ?? this.user,
  );

  final String? enterpriseType;
  final List<String>? permissions;
  final List<String>? roles;
  final User? user;

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable()
class User {
  const User({
    this.createTime,
    this.remark,
    this.userId,
    this.deptId,
    this.userName,
    this.surname,
    this.name,
    this.language,
    this.email,
    this.fsOpenId,
    this.fsUnionId,
    this.fsUserId,
    this.areaCode,
    this.phonenumber,
    this.sex,
    this.avatar,
    this.password,
    this.status,
    this.dept,
    this.roles,
    this.roleIds,
    this.admin,
    this.currency,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final DateTime? createTime;
  final String? remark;
  final int? userId;
  final int? deptId;
  final String? userName;
  final String? surname;
  final String? name;
  final String? language;
  final String? email;
  final String? fsOpenId;
  final String? fsUnionId;
  final String? fsUserId;
  final String? areaCode;
  final String? phonenumber;
  final String? sex;
  final String? avatar;
  final String? password;
  final String? status;
  final Dept? dept;
  final List<Role>? roles;
  final List<int>? roleIds;
  final bool? admin;
  final String? currency;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Dept {
  const Dept({
    this.globalMnoId,
    this.searchValue,
    this.createBy,
    this.createTime,
    this.updateBy,
    this.updateTime,
    this.remark,
    this.deptId,
    this.parentId,
    this.ancestors,
    this.deptName,
    this.orderNum,
    this.leader,
    this.phone,
    this.email,
    this.status,
    this.delFlag,
    this.parentName,
  });

  factory Dept.fromJson(Map<String, dynamic> json) => _$DeptFromJson(json);

  ///运营商id
  final String? globalMnoId;
  final String? searchValue;
  final String? createBy;
  final String? createTime;
  final String? updateBy;
  final String? updateTime;
  final String? remark;
  final int? deptId;
  final int? parentId;
  final String? ancestors;
  final String? deptName;
  final String? orderNum;
  final String? leader;
  final String? phone;
  final String? email;
  final String? status;
  final String? delFlag;
  final String? parentName;

  Map<String, dynamic> toJson() => _$DeptToJson(this);

  @override
  String toString() => deptName ?? '--';
}

@JsonSerializable()
class Role {
  const Role({
    this.searchValue,
    this.createBy,
    this.createTime,
    this.updateBy,
    this.updateTime,
    this.remark,
    this.roleId,
    this.roleName,
    this.roleKey,
    this.roleSort,
    this.dataScope,
    this.menuCheckStrictly,
    this.deptCheckStrictly,
    this.status,
    this.delFlag,
    this.flag,
    this.menuIds,
    this.deptIds,
    this.admin,
  });

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  final dynamic searchValue;
  final dynamic createBy;
  final String? createTime;
  final dynamic updateBy;
  final dynamic updateTime;
  final String? remark;
  final int? roleId;
  final String? roleName;
  final String? roleKey;
  final String? roleSort;
  final String? dataScope;
  final bool? menuCheckStrictly;
  final bool? deptCheckStrictly;
  final String? status;
  final String? delFlag;
  final bool? flag;
  final dynamic menuIds;
  final dynamic deptIds;
  final bool? admin;

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}
