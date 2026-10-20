import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:teachme_mobile/app/router.dart';
import 'package:teachme_mobile/core/storage/prefs.dart';
import 'package:teachme_mobile/core/theme/app_theme.dart';
import 'package:teachme_mobile/core/theme/tokens.dart';
import 'package:teachme_mobile/features/auth/domain/auth_state.dart';
import 'package:teachme_mobile/features/auth/presentation/auth_controller.dart';

class TeachMeApp extends ConsumerWidget {
  const TeachMeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final themeMode = ref.watch(themeModeProvider);
    final router = ref.watch(routerProvider);

    final AppRole? role = authState.mapOrNull(
      authenticated: (auth) => auth.role,
    );

    return MaterialApp.router(
      title: 'teachMe',
      theme: buildTheme(Brightness.light, role: role),
      darkTheme: buildTheme(Brightness.dark, role: role),
      themeMode: themeMode,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('id'),
        Locale('en'),
      ],
    );
  }
}
