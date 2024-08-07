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
}
