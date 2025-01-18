import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../app/colors/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: navigationShell.currentIndex,
      elevation: 0,
      backgroundColor: Colors.transparent,
      indicatorColor: Colors.transparent,
      destinations: [
        NavigationDestination(
          icon: _BottomNavBarItemIcon(
            path: 'assets/icons/home_filled.svg',
          ),
          selectedIcon: _BottomNavBarItemIcon(
            path: 'assets/icons/home_filled.svg',
            color: AppColors.white,
          ),
          label: 'Home',
        ),
        NavigationDestination(
          icon: _BottomNavBarItemIcon(
            path: 'assets/icons/statistics.svg',
          ),
          selectedIcon: _BottomNavBarItemIcon(
            path: 'assets/icons/statistics.svg',
            color: AppColors.white,
          ),
          label: 'Statistics',
        ),
      ],
      onDestinationSelected: _goBranch,
    );
  }
}

class _BottomNavBarItemIcon extends StatelessWidget {
  const _BottomNavBarItemIcon({
    required this.path,
    this.color,
  });
  final String path;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 30,
      child: SvgPicture.asset(
        path,
        colorFilter: ColorFilter.mode(
          color ?? AppColors.grey,
          BlendMode.srcIn,
        ),
        fit: BoxFit.cover,
      ),
    );
  }
}
