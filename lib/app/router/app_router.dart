import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/register/view/register_page.dart';

import '../../home/view/home_page.dart';
import '../../navigation/view/navigation.dart';
import '../../statistics/view/statistics_page.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigator = GlobalKey(debugLabel: 'shell');

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigator,
    initialLocation: '/register',
    routes: [
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
      ShellRoute(
        navigatorKey: _shellNavigator,
        builder: (
          context,
          state,
          child,
        ) =>
            NavigationRoot(
          key: state.pageKey,
          child: child,
        ),
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: HomePage(
                  key: state.pageKey,
                ),
              );
            },
          ),
          GoRoute(
            path: '/statistics',
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: StatisticsPage(
                  key: state.pageKey,
                ),
              );
            },
          ),
        ],
      ),
    ],
  );
}
