import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/colors/app_colors.dart';
import '../../app/spacing/app_spacing.dart';
import '../bloc/habit_bloc.dart';

abstract class HabitColors {
  static List<Color> colors = const [
    Color(0xFF809BCE),
    Color(0xFF95B8D1),
    Color(0xFFFEC89A),
    Color(0xFFFFD7BA),
    Color(0xFFFF7477),
    Color(0xFFECE4DB),
    Color(0xFFD8E2DC),
    Color(0xFFE8E8E4),
    Color(0xFFF8EDEB),
    Color(0xFFFAE1DD),
    Color(0xFFFCD5CE),
  ];
  static Color defaultColor = colors.first;
}

class ColorPicker extends StatelessWidget {
  const ColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: ListView.separated(
        separatorBuilder: (_, __) => SizedBox(width: AppSpacing.xlg),
        scrollDirection: Axis.horizontal,
        itemCount: HabitColors.colors.length,
        itemBuilder: (
          BuildContext context,
          int index,
        ) {
          final color = HabitColors.colors[index];
          return _ColorPickerItem(color: color);
        },
      ),
    );
  }
}

class _ColorPickerItem extends StatelessWidget {
  const _ColorPickerItem({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isSelected =
        context.select((HabitBloc bloc) => bloc.state.color) == color;

    return GestureDetector(
      onTap: () => context.read<HabitBloc>().add(HabitColorChanged(color)),
      child: CircleAvatar(
        backgroundColor: color,
        child: isSelected
            ? Icon(
                Icons.check,
                color: AppColors.background,
                size: 26,
              )
            : null,
      ),
    );
  }
}
