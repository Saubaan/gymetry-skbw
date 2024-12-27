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
      'date': date.toIso8601String(),
    };
  }

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      memberId: json['memberId'],
      date: DateTime.parse(json['date']),
    );
  }
}