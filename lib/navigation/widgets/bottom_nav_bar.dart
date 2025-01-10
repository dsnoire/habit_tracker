import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../app/colors/app_colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  void _onTap(int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/statistics');
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
          _onTap(value);
        },
        elevation: 0,
        backgroundColor: Colors.transparent,
        showUnselectedLabels: false,
        showSelectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            activeIcon: _BottomNavBarItemIcon(
              path: 'assets/icons/home_filled.svg',
              color: Colors.black,
            ),
            icon: _BottomNavBarItemIcon(
              path: 'assets/icons/home.svg',
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: _BottomNavBarItemIcon(
              path: 'assets/icons/statistics.svg',
              color: Colors.black,
            ),
            icon: _BottomNavBarItemIcon(
              path: 'assets/icons/statistics.svg',
            ),
            label: 'Statistics',
          ),
        ],
      ),
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
      height: 28,
      width: 28,
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
