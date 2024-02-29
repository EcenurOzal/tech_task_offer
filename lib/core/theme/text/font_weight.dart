import 'package:flutter/material.dart';

enum AppFontWeight {
  v4(FontWeight.w400),
  v5(FontWeight.w500),
  v6(FontWeight.w600),
  v7(FontWeight.w700);

  final FontWeight rawValue;
  const AppFontWeight(this.rawValue);
}
