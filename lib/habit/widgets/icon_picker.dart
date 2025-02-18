import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../app/colors/app_colors.dart';
import '../../app/spacing/app_spacing.dart';
import '../bloc/habit_bloc.dart';

abstract class HabitIcons {
  static List<IconData> icons = const [
    Icons.call_to_action,
    Icons.book,
    Icons.extension_sharp,
    Icons.build,
    Icons.fitness_center, // for training// for chess
    Icons.music_note, // for music
    Icons.sports_gymnastics, // for gymnastics
    Icons.directions_run, // for running
    Icons.sports_basketball, // for basketball
    Icons.access_alarm, // for time management
    Icons.camera, // for photography
    Icons.art_track, // for painting/art
    Icons.laptop, // for programming
    Icons.brush, // for design
    Icons.coffee, // for coffee time
    Icons.travel_explore, // for traveling
    Icons.group, // for social activities
    Icons.shopping_cart, // for shopping
    Icons.restaurant, // for cooking or dining
    Icons.lightbulb, // for ideas/inspiration
    Icons.headset, // for gaming or music listening
    Icons.watch_later, // for time management
    Icons.work, // for work/business
    Icons.sports_football, // for football
    Icons.pool, // for swimming
    Icons.local_activity, // for outdoor activities
    Icons.pets, // for pet care
    Icons.lunch_dining, // for food-related hobbies// for mindfulness/meditation
    Icons.volunteer_activism, // for volunteering
    Icons.museum, // for visiting museums
    Icons.stadium, // for attending sports events
  ];
  static IconData defaultIcon = icons.first;
}

class IconPicker extends StatelessWidget {
  const IconPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.select((HabitBloc bloc) => bloc.state.color);
    final selectedIcon = context.select((HabitBloc bloc) => bloc.state.icon);
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
            builder: (context) {
              final height =
                  MediaQuery.of(context).size.height - kToolbarHeight - 24;
              return _IconsBottomSheet(height: height);
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
            spacing: AppSpacing.mlg,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(Icons.close),
                  ),
                  Text(
                    'Choose icon',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
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
      onTap: () => context.read<HabitBloc>().add(HabitIconChanged(icon)),
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
    final color = context.select((HabitBloc bloc) => bloc.state.color);
    final icon = context.select((HabitBloc bloc) => bloc.state.icon);
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
