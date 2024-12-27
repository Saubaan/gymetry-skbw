class Member {
  final String uid;
  final String name;
  final String role = 'member';
  final String email;
  final String phone;
  final DateTime expiryDate;
  final bool isPaused ;
  final DateTime pauseStartDate;

  Member({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.expiryDate,
    required this.isPaused,
    required this.pauseStartDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'role': role,
      'email': email,
      'phone': phone,
      'expiryDate': expiryDate.toIso8601String(),
      'isPaused': isPaused,
      'pauseStartDate': pauseStartDate.toIso8601String(),
    };
  }
  
  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      expiryDate: DateTime.parse(json['expiryDate']),
      isPaused: json['isPaused'],
      pauseStartDate: DateTime.parse(json['pauseStartDate']),
    );
  }
}