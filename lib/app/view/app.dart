import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:user_repository/user_repository.dart';

import '../bloc/app_bloc.dart';
import '../router/app_router.dart';
import '../theme/app_theme.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
    required HabitRepository habitRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        _habitRepository = habitRepository;

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  final HabitRepository _habitRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
        RepositoryProvider.value(value: _userRepository),
        RepositoryProvider.value(value: _habitRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (context) => AppBloc(
              _userRepository,
              _authenticationRepository,
            )..add(AppUserSubscriptionRequested()),
          ),
        ],
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Habit Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      routerConfig: AppRouter(context.read<AppBloc>()).router,
    );
  }
}
