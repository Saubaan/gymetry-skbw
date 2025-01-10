import 'package:cloud_firestore/cloud_firestore.dart';

class PendingMember {
  final String name;
  final String email;
  final String phone;
  final DateTime expiryDate;
  final String password;
  final DateTime createdAt;

  PendingMember({
    required this.name,
    required this.email,
    required this.phone,
    required this.expiryDate,
    required this.password,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'name': name,
      'email': email,
      'phone': phone,
      'expiryDate': Timestamp.fromDate(expiryDate),
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory PendingMember.fromJson(Map<String, dynamic> json) {
    return PendingMember(
      password: json['password'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      expiryDate: json['expiryDate'].toDate(),
      createdAt: json['createdAt'].toDate(),
    );
  }
}