class Gym {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String gymCode;

  Gym({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.gymCode,
  });

  Map<String, String> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'gymCode': gymCode,
    };
  }

  factory Gym.fromJson(Map<String, dynamic> json) {
    return Gym(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      gymCode: json['gymCode'],
    );
  }
}
