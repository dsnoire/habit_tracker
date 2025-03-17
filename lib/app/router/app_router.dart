import 'dart:async';

import 'package:database_client/database_client.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../habit_form/view/habit_page.dart';
import '../../home/view/home_page.dart';
import '../../login/view/login_page.dart';
import '../../navigation/view/navigation.dart';
import '../../register/view/register_page.dart';
import '../../settings/view/settings_page.dart';
import '../../statistics/view/statistics_page.dart';
import '../bloc/app_bloc.dart';

final _rootNavigator = GlobalKey<NavigatorState>(debugLabel: 'root');

class AppRouter {
  AppRouter(this._appBloc);
  final AppBloc _appBloc;

  GoRouter get router => GoRouter(
        navigatorKey: _rootNavigator,
        debugLogDiagnostics: true,
        initialLocation: '/home',
        routes: [
          StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              return NavigationRoot(
                navigationShell: navigationShell,
              );
            },
            branches: [
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: '/home',
                    pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: HomePage(),
                    ),
                  )
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: '/statistics',
                    pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: StatisticsPage(),
                    ),
                  )
                ],
              ),
            ],
          ),
          GoRoute(
            path: '/register',
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: RegisterPage(),
              );
            },
          ),
          GoRoute(
            path: '/login',
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: LoginPage(),
              );
            },
          ),
          GoRoute(
            path: '/settings',
            parentNavigatorKey: _rootNavigator,
            pageBuilder: (context, state) {
              return MaterialPage(
                child: SettingsPage(
                  key: state.pageKey,
                ),
              );
            },
          ),
          GoRoute(
            path: '/new-habit',
            parentNavigatorKey: _rootNavigator,
            pageBuilder: (context, state) {
              return MaterialPage(
                child: HabitPage(
                  key: state.pageKey,
                ),
              );
            },
          ),
          GoRoute(
            path: '/edit-habit',
            parentNavigatorKey: _rootNavigator,
            pageBuilder: (context, state) {
              final habit = state.extra as Habit;
              return MaterialPage(
                child: HabitPage(
                  key: state.pageKey,
                  initialHabit: habit,
                ),
              );
            },
          ),
        ],
        redirect: (context, state) {
          final isAuthenticated =
              _appBloc.state.status == AppStatus.authenticated;
          final isInHome = state.matchedLocation == '/home';
          final isAuthenticating = state.matchedLocation == '/login' ||
              state.matchedLocation == '/register';

          if (isInHome && !isAuthenticated) return '/login';
          if (!isAuthenticated && !isAuthenticating) return '/login';
          if (isAuthenticating && isAuthenticated) return '/home';
          return null;
        },
        refreshListenable: _GoRouterAppBlocRefreshStream(_appBloc.stream),
      );
}

class _GoRouterAppBlocRefreshStream extends ChangeNotifier {
  _GoRouterAppBlocRefreshStream(Stream<AppState> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((appState) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
