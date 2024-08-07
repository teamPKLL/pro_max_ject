// repositories/user_repository.dart
import 'package:firebase_database/firebase_database.dart';
import 'package:pro_max_ject/models/user.dart';

class UserRepository {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref('users'); // 'users' 경로에 대한 데이터베이스 참조

  // 사용자 추가 메서드
  Future<void> addUser(User user) async {
    await _databaseRef.child(user.id).set(user.toJson()); // 사용자 ID를 키로 하여 사용자 정보를 데이터베이스에 저장
  }

  // ID로 사용자 조회 메서드
  Future<DataSnapshot> getUserById(String id) async {
    return await _databaseRef.child(id).get(); // 사용자 ID를 키로 하여 데이터베이스에서 사용자 정보 가져오기
  }

  // 유저의 ID와 해시된 비밀번호를 검증하는 메서드
  Future<User?> authenticateUser(String id, String hashedPassword) async {
    DataSnapshot snapshot = await getUserById(id);
    if (snapshot.exists) {
      // 데이터를 Map<String, dynamic>으로 변환
      Map<String, dynamic> userData = Map<String, dynamic>.from(snapshot.value as Map);
      User user = User.fromJson(userData);
      if (user.hashedPassword == hashedPassword) {
        return user;
      }
    }
    return null;
  }
}
