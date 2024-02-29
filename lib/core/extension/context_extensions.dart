import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {
  ColorScheme get xMaterialColorTheme => Theme.of(this).colorScheme;
}
