import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skbwmember/features/member/domain/entities/member.dart';
import 'package:skbwmember/services/notifications/domain/repositories/notification_repo.dart';

class FirebaseNotificationRepo implements NotificationRepo {
  final currentUser = FirebaseAuth.instance.currentUser;
  final memberCollection = FirebaseFirestore.instance.collection('members');

  // Method to check if the user's subscription has expired
  @override
  Future<String?> isExpired() async {
    if (currentUser != null) {
      try {
        final memberDoc = await memberCollection.doc(currentUser!.uid).get();
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);

        if(memberDoc.exists) {
          final Member member = Member.fromJson(memberDoc.data() as Map<String, dynamic>);
          DateTime checkDay = DateTime(member.checkDate.year, member.checkDate.month, member.checkDate.day);
          if (checkDay.isBefore(today)) {
            final expiryDate = member.expiryDate;
            await memberCollection.doc(currentUser!.uid).update({'checkDate': today});
            if (expiryDate.difference(today).inDays == 0) {
              return 'Your subscription has expired, please renew as soon as possible';
            } else if (expiryDate.difference(today).inDays <= 3) {
              return 'Your subscription is expiring in ${expiryDate.difference(today).inDays} days';
            }
          }
        }
        return null;
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }
}
