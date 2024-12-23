import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:skbwtrainer/features/auth/presentation/pages/login_page.dart';
import 'package:skbwtrainer/themes/dark_mode.dart';
import 'package:skbwtrainer/themes/light_mode.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      theme: lightMode,
      darkTheme: darkMode,
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    ),
  );
}