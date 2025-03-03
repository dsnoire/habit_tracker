import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../app/colors/app_colors.dart';
import '../../app/spacing/app_spacing.dart';
import '../bloc/habit_form_bloc.dart';

abstract class HabitIcons {
  static List<IconData> icons = const [
    Icons.call_to_action,
    Icons.book,
    Icons.extension_sharp,
    Icons.build,
    Icons.fitness_center,
    Icons.music_note,
    Icons.sports_gymnastics,
    Icons.directions_run,
    Icons.sports_basketball,
    Icons.access_alarm,
    Icons.camera,
    Icons.art_track,
    Icons.laptop,
    Icons.brush,
    Icons.coffee,
    Icons.travel_explore,
    Icons.group,
    Icons.shopping_cart,
    Icons.restaurant,
    Icons.lightbulb,
    Icons.headset,
    Icons.watch_later,
    Icons.work,
    Icons.sports_football,
    Icons.pool,
    Icons.local_activity,
    Icons.pets,
    Icons.lunch_dining,
    Icons.volunteer_activism,
    Icons.museum,
    Icons.stadium,
  ];
  static IconData defaultIcon = icons.first;
}

class IconPicker extends StatelessWidget {
  const IconPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.select((HabitFormBloc bloc) => bloc.state.color);
    final selectedIcon =
        context.select((HabitFormBloc bloc) => bloc.state.icon);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Habit icon',
          style: TextStyle(
            color: AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        ListTile(
          onTap: () => showModalBottomSheet(
            context: context,
            backgroundColor: AppColors.background,
            isScrollControlled: true,
            builder: (modalContext) {
              final height =
                  MediaQuery.of(context).size.height - kToolbarHeight - 24;
              return BlocProvider.value(
                value: BlocProvider.of<HabitFormBloc>(context),
                child: _IconsBottomSheet(height: height),
              );
            },
          ),
          tileColor: AppColors.surfaceGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          leading: CircleAvatar(
            backgroundColor: color,
            child: Icon(selectedIcon),
          ),
          title: Text('Icon'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}

class _IconsBottomSheet extends StatelessWidget {
  const _IconsBottomSheet({
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            spacing: AppSpacing.xxlg,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Choose icon',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              _SelectedIcon(),
              _IconsGrid(),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: HabitIcons.icons.length,
        itemBuilder: (context, index) {
          final icon = HabitIcons.icons[index];
          return _IconItem(icon: icon);
        },
      ),
    );
  }
}

class _IconItem extends StatelessWidget {
  const _IconItem({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<HabitFormBloc>().add(HabitIconChanged(icon)),
      child: CircleAvatar(
        backgroundColor: AppColors.surfaceGrey,
        child: Icon(
          icon,
          size: 26,
          color: AppColors.white,
        ),
      ),
    );
  }
}

class _SelectedIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = context.select((HabitFormBloc bloc) => bloc.state.color);
    final icon = context.select((HabitFormBloc bloc) => bloc.state.icon);
    return CircleAvatar(
      radius: 45,
      backgroundColor: color,
      child: Icon(
        icon,
        size: 55,
      ),
    );
  }
}
