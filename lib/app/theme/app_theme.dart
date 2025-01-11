import "package:flutter/material.dart";

abstract class AppTheme {
  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF9223FF),
          brightness: Brightness.dark,
        ),
      );
}
