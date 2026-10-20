import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:teachme_mobile/core/storage/token_store.dart';
import 'package:teachme_mobile/core/theme/tokens.dart';
import 'package:teachme_mobile/features/auth/data/auth_api.dart';
import 'package:teachme_mobile/features/auth/data/auth_dto.dart';
import 'package:teachme_mobile/features/auth/domain/auth_state.dart';

class AuthController extends Notifier<AuthState> {
  @override
  AuthState build() {
    _tryRestoreSession();
    return const AuthState.unknown();
  }

  Future<void> _tryRestoreSession() async {
    try {
      final store = ref.read(tokenStoreProvider);
      final accessToken = await store.getAccessToken();
      if (accessToken == null) {
        state = const AuthState.unauthenticated();
        return;
      }
      final api = ref.read(authApiProvider);
      final user = await api.getMe();
      final role = _parseRole(user.role);
      state = AuthState.authenticated(user: user, role: role);
    } catch (_) {
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> login(String email, String password) async {
    final api = ref.read(authApiProvider);
    final store = ref.read(tokenStoreProvider);
    final res = await api.login(LoginRequest(email: email, password: password));
    await store.saveTokens(
      accessToken: res.accessToken,
      refreshToken: res.refreshToken,
    );
    final role = _parseRole(res.user.role);
    await store.saveRole(res.user.role);
    await store.saveUserId(res.user.id);
    state = AuthState.authenticated(user: res.user, role: role);
  }

  Future<void> register(
    String name,
    String email,
    String password,
    String role,
  ) async {
    final api = ref.read(authApiProvider);
    final store = ref.read(tokenStoreProvider);
    final res = await api.register(
      RegisterRequest(name: name, email: email, password: password, role: role),
    );
    await store.saveTokens(
      accessToken: res.accessToken,
      refreshToken: res.refreshToken,
    );
    final parsedRole = _parseRole(res.user.role);
    await store.saveRole(res.user.role);
    await store.saveUserId(res.user.id);
    state = AuthState.authenticated(user: res.user, role: parsedRole);
  }

  Future<void> logout() async {
    final api = ref.read(authApiProvider);
    final store = ref.read(tokenStoreProvider);
    final refreshToken = await store.getRefreshToken();
    if (refreshToken != null) {
      try {
        await api.logout(refreshToken);
      } catch (_) {}
    }
    await store.clear();
    state = const AuthState.unauthenticated();
  }

  AppRole _parseRole(String role) {
    return switch (role.toUpperCase()) {
      'STUDENT' => AppRole.student,
      'TUTOR' => AppRole.tutor,
      _ => AppRole.student,
    };
  }
}

final authControllerProvider =
    NotifierProvider<AuthController, AuthState>(AuthController.new);
