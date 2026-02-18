import 'dart:convert';

import 'package:http/http.dart' as http;

import '../dtos/auth_dtos.dart';

final class AuthApiException implements Exception {
  AuthApiException(this.message, {this.statusCode, this.code});

  final String message;
  final int? statusCode;
  final String? code;

  @override
  String toString() =>
      'AuthApiException(statusCode: $statusCode, code: $code, message: $message)';
}

final class AuthApiClient {
  AuthApiClient({required this.baseUrl, http.Client? client})
    : _client = client ?? http.Client();

  final String baseUrl;
  final http.Client _client;

  Future<LoginResponseDto> login(LoginRequestDto request) async {
    final payload = await _post('/v1/auth/login', body: request.toJson());
    return LoginResponseDto.fromJson(payload);
  }

  Future<RefreshResponseDto> refresh(RefreshRequestDto request) async {
    final payload = await _post('/v1/auth/refresh', body: request.toJson());
    return RefreshResponseDto.fromJson(payload);
  }

  Future<LogoutResponseDto> logout(LogoutRequestDto request) async {
    final payload = await _post('/v1/auth/logout', body: request.toJson());
    return LogoutResponseDto.fromJson(payload);
  }

  Future<MeResponseDto> me({required String accessToken}) async {
    final payload = await _get('/v1/me', accessToken: accessToken);
    return MeResponseDto.fromJson(payload);
  }

  Future<Map<String, dynamic>> _post(
    String path, {
    required Map<String, dynamic> body,
    String? accessToken,
  }) async {
    final uri = Uri.parse('$baseUrl$path');
    final response = await _client.post(
      uri,
      headers: _headers(accessToken),
      body: jsonEncode(body),
    );
    return _decodeEnvelope(response);
  }

  Future<Map<String, dynamic>> _get(String path, {String? accessToken}) async {
    final uri = Uri.parse('$baseUrl$path');
    final response = await _client.get(uri, headers: _headers(accessToken));
    return _decodeEnvelope(response);
  }

  Map<String, String> _headers(String? accessToken) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (accessToken != null && accessToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }

  Map<String, dynamic> _decodeEnvelope(http.Response response) {
    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw AuthApiException(
        'Invalid response shape',
        statusCode: response.statusCode,
      );
    }

    final envelope = ApiEnvelopeDto.fromJson(decoded);
    if (response.statusCode < 200 ||
        response.statusCode >= 300 ||
        !envelope.success) {
      throw AuthApiException(
        envelope.error?.message ?? 'Request failed',
        statusCode: response.statusCode,
        code: envelope.error?.code,
      );
    }

    final data = envelope.data;
    if (data is! Map<String, dynamic>) {
      throw AuthApiException(
        'Response data is missing',
        statusCode: response.statusCode,
      );
    }
    return data;
  }
}
