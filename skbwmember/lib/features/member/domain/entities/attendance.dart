import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance {
  final String memberId;
  final DateTime date;

  Attendance({
    required this.memberId,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'memberId': memberId,
      'date': Timestamp.fromDate(date),
    };
  }

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      memberId: json['memberId'],
      date: json['date'].toDate(),
    );
  }
}