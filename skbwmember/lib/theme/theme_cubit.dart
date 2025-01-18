import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skbwmember/theme/dark_mode.dart';
import 'package:skbwmember/theme/light_mode.dart';

class ThemeCubit extends Cubit<ThemeData> {
  static const String themeKey = "isDarkTheme";

  ThemeCubit() : super(darkMode);

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool isDark = prefs.getBool(themeKey) ?? true;
    emit(isDark ? darkMode : lightMode);
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool isDark = state.brightness == Brightness.dark;
    emit(isDark ? lightMode : darkMode); // Change theme
    await prefs.setBool(themeKey, !isDark); // Save new theme preference
  }
}
