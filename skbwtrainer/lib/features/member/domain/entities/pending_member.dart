import 'member.dart';

class PendingMember extends Member {
  final String password;

  PendingMember({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.expiryDate,
    required super.isPaused,
    required super.pauseStartDate,
    required this.password,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'password': password,
      'name': name,
      'email': email,
      'phone': phone,
      'expiryDate': expiryDate.toIso8601String(),
      'isPaused': isPaused,
      'pauseStartDate': pauseStartDate.toIso8601String(),
    };
  }

  Member toMember() {
    return Member(
      id: id,
      name: name,
      email: email,
      phone: phone,
      expiryDate: expiryDate,
      isPaused: isPaused,
      pauseStartDate: pauseStartDate,
    );
  }

  factory PendingMember.fromJson(Map<String, dynamic> json) {
    return PendingMember(
      id: json['id'],
      password: json['password'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      expiryDate: DateTime.parse(json['expiryDate']),
      isPaused: json['isPaused'],
      pauseStartDate: DateTime.parse(json['pauseStartDate']),
    );
  }
}