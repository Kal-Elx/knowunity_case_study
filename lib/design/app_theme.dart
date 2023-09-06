import 'package:flutter/material.dart';

ThemeData get appTheme {
  const backgroundColor = Color(0xFFF9F9F9);
  final colorScheme = ColorScheme.fromSeed(seedColor: Colors.indigo);

  return ThemeData(
    brightness: Brightness.light,
    colorScheme: colorScheme.copyWith(
      background: backgroundColor,
    ),
    appBarTheme: const AppBarTheme(backgroundColor: backgroundColor),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(colorScheme.inversePrimary),
        foregroundColor: MaterialStateProperty.all(colorScheme.primary),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
    ),
    useMaterial3: true,
  );
}
