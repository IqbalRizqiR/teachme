import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:teachme_mobile/core/theme/tokens.dart';
import 'package:teachme_mobile/features/auth/data/auth_dto.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.unknown() = _Unknown;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.authenticated({
    required AuthUser user,
    required AppRole role,
  }) = _Authenticated;
}
