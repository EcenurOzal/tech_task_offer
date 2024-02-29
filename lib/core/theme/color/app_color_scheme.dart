import 'package:flutter/material.dart';

//? Color scheme for the app
class AppColorScheme {
  final ColorScheme colorScheme;
  final Color surfaceVariant2;
  final Color onSurfaceVariant2;
  final Color onSurfaceVariant3;

  const AppColorScheme({
    required this.colorScheme,
    required this.surfaceVariant2,
    required this.onSurfaceVariant2,
    required this.onSurfaceVariant3,
  });

  Color get primary => colorScheme.primary;
  Color get onPrimary => colorScheme.onPrimary;
  Color get primaryContainer => colorScheme.primaryContainer;
  Color get onPrimaryContainer => colorScheme.onPrimaryContainer;
  Color get surface => colorScheme.surface;
  Color get onSurface => colorScheme.onSurface;
  Color get surfaceVariant => colorScheme.surfaceVariant;
  Color get onSurfaceVariant => colorScheme.onSurfaceVariant;
  Color get outline => colorScheme.outline;
  Color get error => colorScheme.error;
  Color get onError => colorScheme.onError;

  static const light = AppColorScheme(
    colorScheme: ColorScheme.light(
      primary: Color.fromRGBO(232, 82, 39, 1),
      onPrimary: Color.fromRGBO(255, 255, 255, 1),
      primaryContainer: Color.fromRGBO(198, 198, 198, 1),
      onPrimaryContainer: Color.fromRGBO(255, 255, 255, 1),
      surface: Color.fromRGBO(255, 255, 255, 1),
      onSurface: Color.fromRGBO(18, 26, 40, 1),
      surfaceVariant: Color.fromRGBO(248, 250, 254, 1),
      onSurfaceVariant: Color.fromRGBO(116, 117, 121, 1),
      outline: Color.fromRGBO(241, 242, 244, 1),
      error: Color.fromRGBO(218, 30, 40, 1),
      onError: Color.fromRGBO(255, 255, 255, 1),
    ),
    surfaceVariant2: Color.fromRGBO(244, 244, 244, 1),
    onSurfaceVariant2: Color.fromRGBO(165, 165, 165, 1),
    onSurfaceVariant3: Color.fromRGBO(168, 168, 168, 1),
  );
}
