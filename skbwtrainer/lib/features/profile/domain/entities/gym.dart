class Gym {
  final String uid;
  final String name;
  final String address;
  final String phone;
  final String gymCode;

  Gym({
    required this.uid,
    required this.name,
    required this.address,
    required this.phone,
    required this.gymCode,
  });

  Map<String, String> toJson() {
    return {
      'uid': uid,
      'name': name,
      'address': address,
      'phone': phone,
      'gymCode': gymCode,
    };
  }

  factory Gym.fromJson(Map<String, dynamic> json) {
    return Gym(
      uid: json['uid'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      gymCode: json['gymCode'],
    );
  }
}
