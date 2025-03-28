import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../../app/colors/app_colors.dart';
import '../../app/spacing/app_spacing.dart';
import '../bloc/habit_form_bloc.dart';
import '../widgets/color_picker.dart';
import '../widgets/icon_picker.dart';
import '../widgets/schedule_picker.dart';
import '../widgets/weekdays_picker.dart';

class HabitForm extends StatelessWidget {
  const HabitForm({super.key});

  @override
  Widget build(BuildContext context) {
    final isNewHabit =
        context.select((HabitFormBloc bloc) => bloc.state.isNewHabit);
    return BlocListener<HabitFormBloc, HabitFormState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(isNewHabit ? 'New Habit' : 'Edit Habit'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            spacing: AppSpacing.xlg,
            children: [
              _NameTextInput(),
              ColorPicker(),
              IconPicker(),
              WeekdaysPicker(),
              SchedulePicker(),
              Spacer(),
              _DoneButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _NameTextInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError =
        context.select((HabitFormBloc bloc) => bloc.state.name.displayError);
    final initialValue =
        context.select((HabitFormBloc bloc) => bloc.state.name.value);
    return TextFormField(
      initialValue: initialValue,
      onChanged: (value) =>
          context.read<HabitFormBloc>().add(HabitNameChanged(value)),
      decoration: InputDecoration(
        labelText: 'Name',
        errorText: displayError != null ? 'Name cannot be empty' : null,
      ),
    );
  }
}

class _DoneButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgress =
        context.select((HabitFormBloc bloc) => bloc.state.status.isInProgress);

    if (isInProgress) return CircularProgressIndicator();

    final isValid = context.select((HabitFormBloc bloc) => bloc.state.isValid);

    final color = context.select((HabitFormBloc bloc) => bloc.state.color);

    return ElevatedButton(
      onPressed: isValid
          ? () => context.read<HabitFormBloc>().add(HabitFormSubmitted())
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
      ),
      child: Text(
        'Done',
        style: TextStyle(
          color: AppColors.surfaceGrey,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
