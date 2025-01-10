import 'package:flutter/material.dart';
import 'package:habit_tracker/navigation/widgets/bottom_nav_bar.dart';

class NavigationRoot extends StatelessWidget {
  final Widget child;
  const NavigationRoot({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const BottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: CircleBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
