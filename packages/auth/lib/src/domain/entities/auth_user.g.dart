// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthUser _$AuthUserFromJson(Map<String, dynamic> json) => _AuthUser(
  id: json['id'] as String,
  username: json['username'] as String,
  role: $enumDecode(_$AuthRoleEnumMap, json['role']),
);

Map<String, dynamic> _$AuthUserToJson(_AuthUser instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'role': _$AuthRoleEnumMap[instance.role]!,
};

const _$AuthRoleEnumMap = {
  AuthRole.user: 'user',
  AuthRole.organizer: 'organizer',
  AuthRole.admin: 'admin',
};
