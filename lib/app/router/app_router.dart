import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/register/view/register_page.dart';

import '../../home/view/home_page.dart';
import '../../login/view/login_page.dart';
import '../../navigation/view/navigation.dart';
import '../../statistics/view/statistics_page.dart';
import '../bloc/app_bloc.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorHome = GlobalKey(debugLabel: 'home');
final GlobalKey<NavigatorState> _shellNavigatorStatistics = GlobalKey(debugLabel: 'stats');

class AppRouter {
  AppRouter(this._appBloc);
  final AppBloc _appBloc;

  GoRouter get router => GoRouter(
        navigatorKey: _rootNavigator,
        initialLocation: '/register',
        refreshListenable: _GoRouterAppBlocRefreshStream(_appBloc.stream),
        redirect: (context, state) {
          final isAuthenticated = _appBloc.state.status == AppStatus.authenticated;

          if (isAuthenticated && state.uri.path == '/login') {
            return '/home';
          }
          if (isAuthenticated && state.uri.path == '/register') {
            return '/home';
          }
          if (!isAuthenticated && state.uri.path == '/home') {
            return '/login';
          }
          return null;
        },
        routes: [
          StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              return NavigationRoot(navigationShell: navigationShell);
            },
            branches: [
              StatefulShellBranch(
                navigatorKey: _shellNavigatorHome,
                routes: [
                  GoRoute(
                    path: '/home',
                    pageBuilder: (context, state) => NoTransitionPage(
                      child: HomePage(),
                    ),
                  )
                ],
              ),
              StatefulShellBranch(
                navigatorKey: _shellNavigatorStatistics,
                routes: [
                  GoRoute(
                    path: '/statistics',
                    pageBuilder: (context, state) => NoTransitionPage(
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
                child: RegisterPage(
                  key: state.pageKey,
                ),
              );
            },
          ),
          GoRoute(
            path: '/login',
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: LoginPage(
                  key: state.pageKey,
                ),
              );
            },
          ),
        ],
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
