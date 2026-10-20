import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/token_store.dart';
import 'api_error.dart';

class AuthInterceptor extends Interceptor {
  final Ref _ref;
  bool _isRefreshing = false;
  Completer<void>? _refreshCompleter;

  AuthInterceptor(this._ref);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await _ref.read(tokenStoreProvider).getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final data = err.response?.data;
      String? errorCode;
      if (data is Map<String, dynamic>) {
        final errorMap = data['error'] as Map<String, dynamic>?;
        errorCode = errorMap?['code'] as String?;
      }

      if (errorCode == 'TOKEN_EXPIRED') {
        if (_isRefreshing) {
          await _refreshCompleter?.future;
          try {
            final response = await _retry(err.requestOptions);
            handler.resolve(response);
          } on DioException catch (e) {
            handler.reject(e);
          }
          return;
        }

        _isRefreshing = true;
        _refreshCompleter = Completer<void>();

        try {
          final store = _ref.read(tokenStoreProvider);
          final refreshToken = await store.getRefreshToken();
          final baseUrl = err.requestOptions.baseUrl;

          final dio = Dio();
          final response = await dio.post(
            '$baseUrl/auth/refresh',
            data: {'refreshToken': refreshToken},
          );

          final newAccessToken = response.data['accessToken'] as String;
          final newRefreshToken = response.data['refreshToken'] as String;
          await store.saveTokens(
            accessToken: newAccessToken,
            refreshToken: newRefreshToken,
          );

          _refreshCompleter?.complete();

          final retryResponse = await _retry(err.requestOptions);
          handler.resolve(retryResponse);
        } catch (e) {
          await _ref.read(tokenStoreProvider).clear();
          _refreshCompleter?.completeError(e);
          handler.reject(err);
        } finally {
          _isRefreshing = false;
        }
        return;
      }
    }

    final data = err.response?.data;
    if (data is Map<String, dynamic> && data.containsKey('error')) {
      final apiError = ApiError.fromJson(data);
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          type: err.type,
          error: apiError,
        ),
      );
      return;
    }

    handler.next(err);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final accessToken = await _ref.read(tokenStoreProvider).getAccessToken();
    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        'Authorization': 'Bearer $accessToken',
      },
    );
    final dio = Dio(BaseOptions(baseUrl: requestOptions.baseUrl));
    return dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
