import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:skbwmember/config/firebase_options.dart';
import 'package:skbwmember/gymetry.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform);
  runApp(Gymetry());
}