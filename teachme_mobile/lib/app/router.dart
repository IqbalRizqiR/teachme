import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:teachme_mobile/core/theme/app_theme.dart';
import 'package:teachme_mobile/core/theme/tokens.dart';
import 'package:teachme_mobile/core/widgets/app_nav_bar.dart';
import 'package:teachme_mobile/features/auth/domain/auth_state.dart';
import 'package:teachme_mobile/features/auth/presentation/auth_controller.dart';
import 'package:teachme_mobile/features/auth/presentation/login_screen.dart';
import 'package:teachme_mobile/features/auth/presentation/register_screen.dart';
import 'package:teachme_mobile/features/booking/presentation/booking_screen.dart';
import 'package:teachme_mobile/features/booking/presentation/tutor_bookings_screen.dart';
import 'package:teachme_mobile/features/dashboard/presentation/grade_screen.dart';
import 'package:teachme_mobile/features/dashboard/presentation/tutor_dashboard_screen.dart';
import 'package:teachme_mobile/features/notifications/presentation/notification_screen.dart';
import 'package:teachme_mobile/features/profile/presentation/student_profile_screen.dart';
import 'package:teachme_mobile/features/profile/presentation/tutor_profile_screen.dart';
import 'package:teachme_mobile/features/progress/presentation/progress_screen.dart';
import 'package:teachme_mobile/features/schedule/presentation/manage_schedule_screen.dart';
import 'package:teachme_mobile/features/tutors/presentation/search_screen.dart';
import 'package:teachme_mobile/features/tutors/presentation/student_home_screen.dart';
import 'package:teachme_mobile/features/tutors/presentation/tutor_detail_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _studentShellKey = GlobalKey<NavigatorState>();
final _tutorShellKey = GlobalKey<NavigatorState>();

const _tutorPaths = ['/dashboard', '/schedule', '/tutor/bookings', '/tutor-profile'];
const _studentPaths = ['/home', '/learning', '/search'];

bool _matchesAny(String path, List<String> prefixes) {
  return prefixes.any((prefix) => path == prefix || path.startsWith('$prefix/'));
}

ThemeData _shellTheme(BuildContext context, AppRole role) {
  return buildTheme(Theme.of(context).brightness, role: role);
}

Widget _roleShell({
  required BuildContext context,
  required StatefulNavigationShell navigationShell,
  required AppRole role,
  required List<AppNavItem> items,
}) {
  return Theme(
    data: _shellTheme(context, role),
    child: Scaffold(
      body: navigationShell,
      extendBody: true,
      bottomNavigationBar: AppNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: navigationShell.goBranch,
        items: items,
      ),
    ),
  );
}

final routerProvider = Provider<GoRouter>((ref) {
  final refreshListenable = _AuthStateListenable(ref, authControllerProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    refreshListenable: refreshListenable,
    redirect: (context, state) {
      final path = state.uri.path;
      final isAuthRoute = path == '/login' || path == '/register';
      final authState = ref.read(authControllerProvider);

      return authState.map(
        unknown: (_) => null,
        unauthenticated: (_) => isAuthRoute ? null : '/login',
        authenticated: (auth) {
          if (isAuthRoute) {
            return auth.role == AppRole.student ? '/home' : '/dashboard';
          }
          if (auth.role == AppRole.student && _matchesAny(path, _tutorPaths)) {
            return '/home';
          }
          if (auth.role == AppRole.tutor && _matchesAny(path, _studentPaths)) {
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
        builder: (context, state, navigationShell) => _roleShell(
          context: context,
          navigationShell: navigationShell,
          role: AppRole.student,
          items: const [
            AppNavItem(icon: Icons.home_rounded, label: 'Beranda'),
            AppNavItem(icon: Icons.trending_up_rounded, label: 'Belajar'),
            AppNavItem(icon: Icons.person_rounded, label: 'Profil'),
          ],
        ),
        branches: [
          StatefulShellBranch(
            navigatorKey: _studentShellKey,
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const StudentHomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/learning',
                builder: (context, state) => const ProgressScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const StudentProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => _roleShell(
          context: context,
          navigationShell: navigationShell,
          role: AppRole.tutor,
          items: const [
            AppNavItem(icon: Icons.dashboard_rounded, label: 'Dashboard'),
            AppNavItem(icon: Icons.calendar_month_rounded, label: 'Jadwal'),
            AppNavItem(icon: Icons.book_rounded, label: 'Booking'),
            AppNavItem(icon: Icons.person_rounded, label: 'Profil'),
          ],
        ),
        branches: [
          StatefulShellBranch(
            navigatorKey: _tutorShellKey,
            routes: [
              GoRoute(
                path: '/dashboard',
                builder: (context, state) => const TutorDashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/schedule',
                builder: (context, state) => const ManageScheduleScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/tutor/bookings',
                builder: (context, state) => const TutorBookingsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/tutor-profile',
                builder: (context, state) => const TutorProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/search',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: '/notifications',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(
        path: '/tutors/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => TutorDetailScreen(
          tutorId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/bookings/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => BookingScreen(
          bookingId: state.pathParameters['id']!,
        ),
        routes: [
          GoRoute(
            path: 'grade',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) => GradeScreen(
              bookingId: state.pathParameters['id']!,
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
