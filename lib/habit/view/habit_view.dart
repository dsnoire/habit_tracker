import 'package:flutter/material.dart';
import 'package:habit_tracker/habit/widgets/color_picker.dart';

class HabitView extends StatelessWidget {
  const HabitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Habit'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _NameTextInput(),
            ColorPicker(),
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
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Name',
      ),
    );
  }
}

class _DoneButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text('Done'),
    );
  }
}
