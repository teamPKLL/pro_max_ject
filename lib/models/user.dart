/// 사용자 모델
class User {
  /// 사용자 이름
  String name;

  /// 사용자 ID
  String id;

  /// 해시화된 비밀번호
  String hashedPassword;

  /// 생성자
  User({
    required this.name,
    required this.id,
    required this.hashedPassword,
  });

  /// User 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'password': hashedPassword,
    };
  }

  /// JSON을 User 객체로 변환
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      id: json['id'] as String,
      hashedPassword: json['password'] as String,
    );
  }
}
