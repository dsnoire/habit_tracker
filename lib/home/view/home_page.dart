import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/bloc/app_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [TextButton(onPressed: () => context.read<AppBloc>().add(AppLogOutPressed()), child: Text('Log out'))],
      ),
    );
  }
}
