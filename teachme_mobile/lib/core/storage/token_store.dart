import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenStore {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<String?> getAccessToken() => _storage.read(key: 'access_token');

  Future<String?> getRefreshToken() => _storage.read(key: 'refresh_token');

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: 'access_token', value: accessToken);
    await _storage.write(key: 'refresh_token', value: refreshToken);
  }

  Future<void> clear() => _storage.deleteAll();

  Future<String?> getRole() => _storage.read(key: 'role');

  Future<void> saveRole(String role) =>
      _storage.write(key: 'role', value: role);

  Future<String?> getUserId() => _storage.read(key: 'user_id');

  Future<void> saveUserId(String id) =>
      _storage.write(key: 'user_id', value: id);
}

final tokenStoreProvider = Provider<TokenStore>((ref) => TokenStore());
