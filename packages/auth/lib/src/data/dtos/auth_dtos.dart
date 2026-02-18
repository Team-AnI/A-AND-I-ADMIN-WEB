import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_dtos.freezed.dart';
part 'auth_dtos.g.dart';

enum AuthRoleDto {
  @JsonValue('USER')
  user,
  @JsonValue('ORGANIZER')
  organizer,
  @JsonValue('ADMIN')
  admin,
}

@freezed
abstract class ApiErrorDto with _$ApiErrorDto {
  const factory ApiErrorDto({String? code, String? message}) = _ApiErrorDto;

  factory ApiErrorDto.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorDtoFromJson(json);
}

@freezed
abstract class LoginRequestDto with _$LoginRequestDto {
  const factory LoginRequestDto({
    required String username,
    required String password,
  }) = _LoginRequestDto;

  factory LoginRequestDto.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestDtoFromJson(json);
}

@freezed
abstract class RefreshRequestDto with _$RefreshRequestDto {
  const factory RefreshRequestDto({required String refreshToken}) =
      _RefreshRequestDto;

  factory RefreshRequestDto.fromJson(Map<String, dynamic> json) =>
      _$RefreshRequestDtoFromJson(json);
}

@freezed
abstract class LogoutRequestDto with _$LogoutRequestDto {
  const factory LogoutRequestDto({required String refreshToken}) =
      _LogoutRequestDto;

  factory LogoutRequestDto.fromJson(Map<String, dynamic> json) =>
      _$LogoutRequestDtoFromJson(json);
}

@freezed
abstract class LoginUserDto with _$LoginUserDto {
  const factory LoginUserDto({
    required String id,
    required String username,
    required AuthRoleDto role,
  }) = _LoginUserDto;

  factory LoginUserDto.fromJson(Map<String, dynamic> json) =>
      _$LoginUserDtoFromJson(json);
}

@freezed
abstract class LoginResponseDto with _$LoginResponseDto {
  const factory LoginResponseDto({
    required String accessToken,
    required String refreshToken,
    required int expiresIn,
    String? tokenType,
    required LoginUserDto user,
  }) = _LoginResponseDto;

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDtoFromJson(json);
}

@freezed
abstract class RefreshResponseDto with _$RefreshResponseDto {
  const factory RefreshResponseDto({
    required String accessToken,
    required int expiresIn,
  }) = _RefreshResponseDto;

  factory RefreshResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RefreshResponseDtoFromJson(json);
}

@freezed
abstract class LogoutResponseDto with _$LogoutResponseDto {
  const factory LogoutResponseDto({required bool success}) = _LogoutResponseDto;

  factory LogoutResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LogoutResponseDtoFromJson(json);
}

@freezed
abstract class MeResponseDto with _$MeResponseDto {
  const factory MeResponseDto({
    required String id,
    required String username,
    required AuthRoleDto role,
  }) = _MeResponseDto;

  factory MeResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MeResponseDtoFromJson(json);
}

@freezed
abstract class ApiEnvelopeDto with _$ApiEnvelopeDto {
  const factory ApiEnvelopeDto({
    required bool success,
    Object? data,
    ApiErrorDto? error,
    DateTime? timestamp,
  }) = _ApiEnvelopeDto;

  factory ApiEnvelopeDto.fromJson(Map<String, dynamic> json) =>
      _$ApiEnvelopeDtoFromJson(json);
}
