import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Color(0xFFFF9900), // Lime green as the primary color
    onPrimary: Color(0xFF000000), // Black for text/icons on primary
    secondary: Color(0xFFFFFFFF), // White as the secondary color
    onSecondary: Color(0xFF000000), // Black for text/icons on background
    tertiary: Color(0xFF363636),
    onTertiary: Color(0xFFFFFFFF),
    surface: Color(0xFFF0F0F0), // White for surface elements (e.g., card backgrounds)
    onSurface: Color(0xFF000000), // Black for text/icons on surface
    error: Color(0xFFB00020), // Red for errors
    onError: Color(0xFFFFFFFF), // White for text/icons on errors
  ),
  textTheme: ThemeData.light().textTheme.apply(
    bodyColor: Colors.grey.shade800,
    displayColor: Colors.black,
  ),
);