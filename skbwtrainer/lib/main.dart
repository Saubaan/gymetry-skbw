import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:skbwtrainer/config/firebase_options.dart';
import 'package:skbwtrainer/gymetry.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(Gymetry());
}