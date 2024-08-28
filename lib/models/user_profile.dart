class Profile {
  String? id; // Document ID from Firestore
  String user_id; //User's ID as FK
  String name;
  String email;
  String birth;

  Profile({
    this.id,
    required this.user_id,
    required this.name,
    required this.email,
    required this.birth,
  });

  // Convert Profile object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'name': name,
      'email': email,
      'birth': birth,
    };
  }

  // Create Profile object from JSON
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] as String?,
      user_id: json['user_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      birth: json['birth'] as String,
    );
  }
}
