import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:teachme_mobile/core/network/dio_client.dart';

import 'auth_dto.dart';

class AuthApi {
  final Dio _dio;

  AuthApi(this._dio);

  Future<AuthResponse> login(LoginRequest req) async {
    final response = await _dio.post('/auth/login', data: req.toJson());
    return AuthResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<AuthResponse> register(RegisterRequest req) async {
    final response = await _dio.post('/auth/register', data: req.toJson());
    return AuthResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<AuthResponse> refresh(String refreshToken) async {
    final response = await _dio.post(
      '/auth/refresh',
      data: {'refreshToken': refreshToken},
    );
    return AuthResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> logout(String refreshToken) async {
    await _dio.post<void>('/auth/logout', data: {'refreshToken': refreshToken});
  }

  Future<AuthUser> getMe() async {
    final response = await _dio.get('/auth/me');
    final data = response.data as Map<String, dynamic>;
    return AuthUser(
      id: data['id'] as String,
      name: data['name'] as String,
      email: data['email'] as String,
      role: data['role'] as String,
      avatarUrl: data['avatarUrl'] as String? ?? data['avatarPath'] as String?,
    );
  }
}

final authApiProvider = Provider<AuthApi>((ref) {
  return AuthApi(ref.watch(dioProvider));
});
