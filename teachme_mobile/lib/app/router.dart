import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:teachme_mobile/core/theme/tokens.dart';
import 'package:teachme_mobile/core/widgets/app_nav_bar.dart';
import 'package:teachme_mobile/features/auth/domain/auth_state.dart';
import 'package:teachme_mobile/features/auth/presentation/auth_controller.dart';
import 'package:teachme_mobile/features/auth/presentation/login_screen.dart';
import 'package:teachme_mobile/features/auth/presentation/register_screen.dart';
import 'package:teachme_mobile/features/placeholder_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _studentShellKey = GlobalKey<NavigatorState>();
final _tutorShellKey = GlobalKey<NavigatorState>();

const _tutorPaths = ['/dashboard', '/schedule', '/tutor-profile'];
const _studentPaths = ['/home', '/learning'];

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    refreshListenable: _AuthStateListenable(ref, authControllerProvider),
    redirect: (context, state) {
      final path = state.uri.path;
      final isAuth = path == '/login' || path == '/register';

      return authState.map(
        unknown: (_) => null,
        unauthenticated: (_) => isAuth ? null : '/login',
        authenticated: (auth) {
          if (isAuth) {
            return auth.role == AppRole.student ? '/home' : '/dashboard';
          }
          if (auth.role == AppRole.student &&
              _tutorPaths.any((r) => path.startsWith(r))) {
            return '/home';
          }
          if (auth.role == AppRole.tutor &&
              _studentPaths.any((r) => path.startsWith(r))) {
            return '/dashboard';
          }
          return null;
        },
      );
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Scaffold(
            body: navigationShell,
            bottomNavigationBar: AppNavBar(
              currentIndex: navigationShell.currentIndex,
              onTap: navigationShell.goBranch,
              items: const [
                AppNavItem(icon: Icons.home_rounded, label: 'Beranda'),
                AppNavItem(icon: Icons.trending_up_rounded, label: 'Belajar'),
                AppNavItem(icon: Icons.person_rounded, label: 'Profil'),
              ],
            ),
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _studentShellKey,
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) =>
                    const PlaceholderScreen(title: 'Beranda'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/learning',
                builder: (context, state) =>
                    const PlaceholderScreen(title: 'Progress Belajar'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                pageBuilder: (context, state) {
                  return const NoTransitionPage(
                    child: PlaceholderScreen(title: 'Profil'),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Scaffold(
            body: navigationShell,
            bottomNavigationBar: AppNavBar(
              currentIndex: navigationShell.currentIndex,
              onTap: navigationShell.goBranch,
              items: const [
                AppNavItem(icon: Icons.dashboard_rounded, label: 'Dashboard'),
                AppNavItem(icon: Icons.calendar_month_rounded, label: 'Jadwal'),
                AppNavItem(icon: Icons.book_rounded, label: 'Booking'),
                AppNavItem(icon: Icons.person_rounded, label: 'Profil'),
              ],
            ),
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _tutorShellKey,
            routes: [
              GoRoute(
                path: '/dashboard',
                builder: (context, state) =>
                    const PlaceholderScreen(title: 'Dashboard'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/schedule',
                builder: (context, state) =>
                    const PlaceholderScreen(title: 'Kelola Jadwal'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/bookings',
                builder: (context, state) =>
                    const PlaceholderScreen(title: 'Daftar Booking'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/tutor-profile',
                builder: (context, state) =>
                    const PlaceholderScreen(title: 'Profil Tutor'),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/tutors/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => PlaceholderScreen(
          title: 'Tutor ${state.pathParameters['id']}',
        ),
      ),
      GoRoute(
        path: '/bookings/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => PlaceholderScreen(
          title: 'Booking ${state.pathParameters['id']}',
        ),
        routes: [
          GoRoute(
            path: 'grade',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) => PlaceholderScreen(
              title: 'Nilai Booking ${state.pathParameters['id']}',
            ),
          ),
        ],
      ),
    ],
  );
});

class _AuthStateListenable extends ChangeNotifier {
  _AuthStateListenable(this._ref, this._provider) {
    _ref.listen(_provider, (previous, next) => notifyListeners());
  }

  final Ref _ref;
  final NotifierProvider<AuthController, AuthState> _provider;
}
