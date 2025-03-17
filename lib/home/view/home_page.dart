import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:habit_tracker/habits_overview/bloc/habits_overview_bloc.dart';
import 'package:habit_tracker/home/view/home_view.dart';
import '../../app/extensions/extensions.dart';
import '../cubit/date_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HabitsOverviewBloc(
            context.read<HabitRepository>(),
          )
            ..add(
              HabitsOverviewSubscriptionRequested(),
            )
            ..add(
              HabitsOverviewByDateRequested(
                now.dayOfTheWeek,
                now,
              ),
            ),
        ),
        BlocProvider(
          create: (context) => DateCubit(),
        ),
      ],
      child: HomeView(),
    );
  }
}
