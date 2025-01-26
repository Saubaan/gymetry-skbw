import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:skbwmember/config/firebase_options.dart';
import 'package:skbwmember/gymetry.dart';
import 'package:skbwmember/services/notifications/data/firebase_notification_repo.dart';
import 'package:skbwmember/services/notifications/presentation/components/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.initialize();
  final notificationRepo = FirebaseNotificationRepo();
  runApp(Gymetry());
  String? expiryMessage = await notificationRepo.isExpired();
  if (expiryMessage != null) {
    NotificationService.showExpiryNotification(
      0,
      'Subscription Expiry Alert!',
      expiryMessage,
    );
  }
}