import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/navigation/widgets/bottom_nav_bar.dart';

class NavigationRoot extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const NavigationRoot({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavBar(navigationShell: navigationShell),
      floatingActionButton: AddHabit(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class AddHabit extends StatelessWidget {
  const AddHabit({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: FloatingActionButton(
        elevation: 0,
        highlightElevation: 0,
        onPressed: () => context.push('/new-habit'),
        shape: CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 26,
        ),
      ),
    );
  }
}
