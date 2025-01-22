import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/app/colors/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Today'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () => context.push('/settings'),
              icon: Icon(
                Icons.settings,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
