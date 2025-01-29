import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> deleteOldAttendance() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference attendanceCollection = firestore.collection('attendance');
  try {
    // Delete attendance documents older than a year
    final yearAgo = Timestamp.fromDate(DateTime.now().subtract(Duration(days: 365)));
    await attendanceCollection
        .where('date', isLessThan: yearAgo)
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
  } catch (e) {
    throw Exception(e);
  }
}