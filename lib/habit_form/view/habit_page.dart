import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:habit_tracker/habit_form/bloc/habit_form_bloc.dart';
import 'habit_form.dart';

class HabitPage extends StatelessWidget {
  const HabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HabitFormBloc(context.read<HabitRepository>()),
      child: const HabitForm(),
    );
  }
}
