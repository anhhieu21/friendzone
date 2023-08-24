import 'package:flutter/material.dart';

extension DarkMode on BuildContext{
  bool get isDarkMode {
    final brightness = Theme.of(this).brightness;
    return brightness == Brightness.dark;
  }
}