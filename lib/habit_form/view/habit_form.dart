import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../app/colors/app_colors.dart';
import '../../app/spacing/app_spacing.dart';
import '../bloc/habit_bloc.dart';
import '../widgets/color_picker.dart';
import '../widgets/icon_picker.dart';
import '../widgets/schedule_picker.dart';
import '../widgets/weekdays_picker.dart';

class HabitForm extends StatelessWidget {
  const HabitForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Habit'),
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
    );
  }
}

class _NameTextInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError =
        context.select((HabitBloc bloc) => bloc.state.name.displayError);
    return TextField(
      onChanged: (value) =>
          context.read<HabitBloc>().add(HabitNameChanged(value)),
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
        context.select((HabitBloc bloc) => bloc.state.status.isInProgress);

    if (isInProgress) return CircularProgressIndicator();

    final isValid = context.select((HabitBloc bloc) => bloc.state.isValid);

    final color = context.select((HabitBloc bloc) => bloc.state.color);

    return ElevatedButton(
      onPressed: isValid
          ? () => context.read<HabitBloc>().add(HabitFormSubmitted())
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
