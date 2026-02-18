// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApiErrorDto _$ApiErrorDtoFromJson(Map<String, dynamic> json) => _ApiErrorDto(
  code: json['code'] as String?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$ApiErrorDtoToJson(_ApiErrorDto instance) =>
    <String, dynamic>{'code': instance.code, 'message': instance.message};

_LoginRequestDto _$LoginRequestDtoFromJson(Map<String, dynamic> json) =>
    _LoginRequestDto(
      username: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestDtoToJson(_LoginRequestDto instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

_RefreshRequestDto _$RefreshRequestDtoFromJson(Map<String, dynamic> json) =>
    _RefreshRequestDto(refreshToken: json['refreshToken'] as String);

Map<String, dynamic> _$RefreshRequestDtoToJson(_RefreshRequestDto instance) =>
    <String, dynamic>{'refreshToken': instance.refreshToken};

_LogoutRequestDto _$LogoutRequestDtoFromJson(Map<String, dynamic> json) =>
    _LogoutRequestDto(refreshToken: json['refreshToken'] as String);

Map<String, dynamic> _$LogoutRequestDtoToJson(_LogoutRequestDto instance) =>
    <String, dynamic>{'refreshToken': instance.refreshToken};

_LoginUserDto _$LoginUserDtoFromJson(Map<String, dynamic> json) =>
    _LoginUserDto(
      id: json['id'] as String,
      username: json['username'] as String,
      role: $enumDecode(_$AuthRoleDtoEnumMap, json['role']),
    );

Map<String, dynamic> _$LoginUserDtoToJson(_LoginUserDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'role': _$AuthRoleDtoEnumMap[instance.role]!,
    };

const _$AuthRoleDtoEnumMap = {
  AuthRoleDto.user: 'USER',
  AuthRoleDto.organizer: 'ORGANIZER',
  AuthRoleDto.admin: 'ADMIN',
};

_LoginResponseDto _$LoginResponseDtoFromJson(Map<String, dynamic> json) =>
    _LoginResponseDto(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn: (json['expiresIn'] as num).toInt(),
      tokenType: json['tokenType'] as String?,
      user: LoginUserDto.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseDtoToJson(_LoginResponseDto instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
      'tokenType': instance.tokenType,
      'user': instance.user,
    };

_RefreshResponseDto _$RefreshResponseDtoFromJson(Map<String, dynamic> json) =>
    _RefreshResponseDto(
      accessToken: json['accessToken'] as String,
      expiresIn: (json['expiresIn'] as num).toInt(),
    );

Map<String, dynamic> _$RefreshResponseDtoToJson(_RefreshResponseDto instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'expiresIn': instance.expiresIn,
    };

_LogoutResponseDto _$LogoutResponseDtoFromJson(Map<String, dynamic> json) =>
    _LogoutResponseDto(success: json['success'] as bool);

Map<String, dynamic> _$LogoutResponseDtoToJson(_LogoutResponseDto instance) =>
    <String, dynamic>{'success': instance.success};

_MeResponseDto _$MeResponseDtoFromJson(Map<String, dynamic> json) =>
    _MeResponseDto(
      id: json['id'] as String,
      username: json['username'] as String,
      role: $enumDecode(_$AuthRoleDtoEnumMap, json['role']),
    );

Map<String, dynamic> _$MeResponseDtoToJson(_MeResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'role': _$AuthRoleDtoEnumMap[instance.role]!,
    };

_ApiEnvelopeDto _$ApiEnvelopeDtoFromJson(Map<String, dynamic> json) =>
    _ApiEnvelopeDto(
      success: json['success'] as bool,
      data: json['data'],
      error: json['error'] == null
          ? null
          : ApiErrorDto.fromJson(json['error'] as Map<String, dynamic>),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$ApiEnvelopeDtoToJson(_ApiEnvelopeDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'error': instance.error,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
