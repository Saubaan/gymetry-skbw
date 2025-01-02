import 'package:cloud_firestore/cloud_firestore.dart';

import 'member.dart';

class PendingMember extends Member {
  final String password;

  PendingMember({
    required super.uid,
    required super.name,
    required super.email,
    required super.phone,
    required super.expiryDate,
    required super.isPaused,
    required super.pauseStartDate,
    required this.password,
    required super.createdAt,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'password': password,
      'name': name,
      'email': email,
      'phone': phone,
      'expiryDate': Timestamp.fromDate(expiryDate),
      'isPaused': isPaused,
      'pauseStartDate': Timestamp.fromDate(pauseStartDate),
    };
  }

  Member toMember() {
    return Member(
      uid: uid,
      name: name,
      email: email,
      phone: phone,
      expiryDate: expiryDate,
      isPaused: isPaused,
      pauseStartDate: pauseStartDate,
      createdAt: createdAt,
    );
  }

  factory PendingMember.fromJson(Map<String, dynamic> json) {
    return PendingMember(
      uid: json['uid'],
      password: json['password'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      expiryDate: json['expiryDate'].toDate(),
      isPaused: json['isPaused'],
      pauseStartDate: json['pauseStartDate'].toDate(),
      createdAt: json['createdAt'].toDate(),
    );
  }
}
