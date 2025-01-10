class AppUser {
  final String uid;
  final String name;
  final String email;

  const AppUser({
    required this.uid,
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
    );
  }
}