import 'package:cloud_firestore/cloud_firestore.dart';

class Member {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final DateTime createdAt;
  final DateTime expiryDate;
  final bool isPaused;
  final DateTime pauseStartDate;
  final DateTime checkDate;

  Member({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.createdAt,
    required this.expiryDate,
    required this.isPaused,
    required this.pauseStartDate,
    required this.checkDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'expiryDate': Timestamp.fromDate(expiryDate),
      'isPaused': isPaused,
      'pauseStartDate': Timestamp.fromDate(pauseStartDate),
      'createdAt': Timestamp.fromDate(createdAt),
      'checkDate': Timestamp.fromDate(checkDate),
    };
  }

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      expiryDate: json['expiryDate'].toDate(),
      isPaused: json['isPaused'],
      pauseStartDate: json['pauseStartDate'].toDate(),
      createdAt: json['createdAt'].toDate(),
      checkDate: json['checkDate'].toDate(),
    );
  }

  Member copyWith({
    String? avatar,
    String? uid,
    String? name,
    String? email,
    String? phone,
    DateTime? createdAt,
    DateTime? expiryDate,
    bool? isPaused,
    DateTime? pauseStartDate,
    DateTime? checkDate,
  }) {
    return Member(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
      expiryDate: expiryDate ?? this.expiryDate,
      isPaused: isPaused ?? this.isPaused,
      pauseStartDate: pauseStartDate ?? this.pauseStartDate,
      checkDate: checkDate ?? this.checkDate,
    );
  }
}
