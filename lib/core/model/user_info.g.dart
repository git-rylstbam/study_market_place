// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      code: (json['code'] as num?)?.toInt(),
      msg: json['msg'] as String?,
      enterpriseType: json['enterpriseType'] as String?,
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'enterpriseType': instance.enterpriseType,
      'permissions': instance.permissions,
      'roles': instance.roles,
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      createTime: json['createTime'] == null
          ? null
          : DateTime.parse(json['createTime'] as String),
      remark: json['remark'] as String?,
      userId: (json['userId'] as num?)?.toInt(),
      deptId: (json['deptId'] as num?)?.toInt(),
      userName: json['userName'] as String?,
      surname: json['surname'] as String?,
      name: json['name'] as String?,
      language: json['language'] as String?,
      email: json['email'] as String?,
      fsOpenId: json['fsOpenId'] as String?,
      fsUnionId: json['fsUnionId'] as String?,
      fsUserId: json['fsUserId'] as String?,
      areaCode: json['areaCode'] as String?,
      phonenumber: json['phonenumber'] as String?,
      sex: json['sex'] as String?,
      avatar: json['avatar'] as String?,
      password: json['password'] as String?,
      status: json['status'] as String?,
      dept: json['dept'] == null
          ? null
          : Dept.fromJson(json['dept'] as Map<String, dynamic>),
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList(),
      roleIds: (json['roleIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      admin: json['admin'] as bool?,
      currency: json['currency'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'createTime': instance.createTime?.toIso8601String(),
      'remark': instance.remark,
      'userId': instance.userId,
      'deptId': instance.deptId,
      'userName': instance.userName,
      'surname': instance.surname,
      'name': instance.name,
      'language': instance.language,
      'email': instance.email,
      'fsOpenId': instance.fsOpenId,
      'fsUnionId': instance.fsUnionId,
      'fsUserId': instance.fsUserId,
      'areaCode': instance.areaCode,
      'phonenumber': instance.phonenumber,
      'sex': instance.sex,
      'avatar': instance.avatar,
      'password': instance.password,
      'status': instance.status,
      'dept': instance.dept,
      'roles': instance.roles,
      'roleIds': instance.roleIds,
      'admin': instance.admin,
      'currency': instance.currency,
    };

Dept _$DeptFromJson(Map<String, dynamic> json) => Dept(
      globalMnoId: json['globalMnoId'] as String?,
      searchValue: json['searchValue'] as String?,
      createBy: json['createBy'] as String?,
      createTime: json['createTime'] as String?,
      updateBy: json['updateBy'] as String?,
      updateTime: json['updateTime'] as String?,
      remark: json['remark'] as String?,
      deptId: (json['deptId'] as num?)?.toInt(),
      parentId: (json['parentId'] as num?)?.toInt(),
      ancestors: json['ancestors'] as String?,
      deptName: json['deptName'] as String?,
      orderNum: json['orderNum'] as String?,
      leader: json['leader'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      status: json['status'] as String?,
      delFlag: json['delFlag'] as String?,
      parentName: json['parentName'] as String?,
    );

Map<String, dynamic> _$DeptToJson(Dept instance) => <String, dynamic>{
      'globalMnoId': instance.globalMnoId,
      'searchValue': instance.searchValue,
      'createBy': instance.createBy,
      'createTime': instance.createTime,
      'updateBy': instance.updateBy,
      'updateTime': instance.updateTime,
      'remark': instance.remark,
      'deptId': instance.deptId,
      'parentId': instance.parentId,
      'ancestors': instance.ancestors,
      'deptName': instance.deptName,
      'orderNum': instance.orderNum,
      'leader': instance.leader,
      'phone': instance.phone,
      'email': instance.email,
      'status': instance.status,
      'delFlag': instance.delFlag,
      'parentName': instance.parentName,
    };

Role _$RoleFromJson(Map<String, dynamic> json) => Role(
      searchValue: json['searchValue'],
      createBy: json['createBy'],
      createTime: json['createTime'] as String?,
      updateBy: json['updateBy'],
      updateTime: json['updateTime'],
      remark: json['remark'] as String?,
      roleId: (json['roleId'] as num?)?.toInt(),
      roleName: json['roleName'] as String?,
      roleKey: json['roleKey'] as String?,
      roleSort: json['roleSort'] as String?,
      dataScope: json['dataScope'] as String?,
      menuCheckStrictly: json['menuCheckStrictly'] as bool?,
      deptCheckStrictly: json['deptCheckStrictly'] as bool?,
      status: json['status'] as String?,
      delFlag: json['delFlag'] as String?,
      flag: json['flag'] as bool?,
      menuIds: json['menuIds'],
      deptIds: json['deptIds'],
      admin: json['admin'] as bool?,
    );

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'searchValue': instance.searchValue,
      'createBy': instance.createBy,
      'createTime': instance.createTime,
      'updateBy': instance.updateBy,
      'updateTime': instance.updateTime,
      'remark': instance.remark,
      'roleId': instance.roleId,
      'roleName': instance.roleName,
      'roleKey': instance.roleKey,
      'roleSort': instance.roleSort,
      'dataScope': instance.dataScope,
      'menuCheckStrictly': instance.menuCheckStrictly,
      'deptCheckStrictly': instance.deptCheckStrictly,
      'status': instance.status,
      'delFlag': instance.delFlag,
      'flag': instance.flag,
      'menuIds': instance.menuIds,
      'deptIds': instance.deptIds,
      'admin': instance.admin,
    };
