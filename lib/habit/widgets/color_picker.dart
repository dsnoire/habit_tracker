import 'package:flutter/material.dart';
import 'package:habit_tracker/app/colors/app_colors.dart';

final Map<int, bool> _colors = {
  const Color(0xFF809BCE).value: false,
  const Color(0xFF95B8D1).value: false,
  const Color(0xFFFEC89A).value: false,
  const Color(0xFFFFD7BA).value: false,
  const Color(0xFFFF7477).value: false,
  const Color(0xFFECE4DB).value: false,
  const Color(0xFFD8E2DC).value: false,
  const Color(0xFFE8E8E4).value: false,
  const Color(0xFFF8EDEB).value: false,
  const Color(0xFFFAE1DD).value: false,
  const Color(0xFFFCD5CE).value: false,
};

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key});

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: ListView.separated(
        separatorBuilder: (_, __) => const SizedBox(width: 20),
        scrollDirection: Axis.horizontal,
        itemCount: _colors.length,
        itemBuilder: (
          BuildContext context,
          int index,
        ) {
          final selectedColor = _colors.keys.elementAt(index);
          final isSelected = _colors.values.elementAt(index) == true;
          return GestureDetector(
            onTap: () {
              setState(
                () {
                  _colors.updateAll(
                    (key, value) {
                      if (key == selectedColor) {
                        return true;
                      } else {
                        return false;
                      }
                    },
                  );
                },
              );
            },
            child: CircleAvatar(
              backgroundColor: Color(selectedColor),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      color: AppColors.white,
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
