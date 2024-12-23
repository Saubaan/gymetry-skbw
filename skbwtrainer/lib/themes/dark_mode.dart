import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Color(0xFFEF9100), // Green as the primary color
    onPrimary: Color(0xFF000000), // Black for text/icons on primary
    secondary: Color(0xFF000000), // Black as the secondary color
    onSecondary: Color(0xFFFFFFFF), // White for text/icons on background
    tertiary: Color(0xFF363636),
    onTertiary: Color(0xFFFFFFFF),
    surface: Color(0xFF121212), // Dark grey for surface elements (e.g., card backgrounds)
    onSurface: Color(0xFFFFFFFF), // White for text/icons on surface
    error: Color(0xFFB00020), // Red for errors
    onError: Color(0xFFFFFFFF), // White for text/icons on errors
  ),
  textTheme: ThemeData.dark().textTheme.apply(
    bodyColor: Colors.grey.shade300,
    displayColor: Colors.white,
  ),
);