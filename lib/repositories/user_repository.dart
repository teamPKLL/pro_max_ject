import 'package:firebase_database/firebase_database.dart';
import 'package:pro_max_ject/models/user.dart';
import 'package:pro_max_ject/models/user_profile.dart';

class UserRepository {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref('users');
  final DatabaseReference _profilesRef = FirebaseDatabase.instance.ref('profiles'); // 'profiles' 경로에 대한 데이터베이스 참조

  // 사용자 추가 메서드
  Future<void> addUser(User_Auth user) async {
    try {
      // 사용자 추가
      DatabaseReference newUserRef = _databaseRef.push();
      user.id = newUserRef.key;
      await newUserRef.set(user.toJson());

      // 프로필 생성
      Profile profile = Profile(
        id: null,
        user_id: user.id!,
        name: 'Default Name',
        email: '',
        birth: '', // 기본값 설정
      );
      await addProfile(profile);
    } catch (e) {
      print('Error adding user: $e');
    }
  }

  // 프로필 추가 메서드
  Future<void> addProfile(Profile profile) async {
    try {
      DatabaseReference newProfileRef = _profilesRef.push();
      profile.id = newProfileRef.key;
      await newProfileRef.set(profile.toJson());
    } catch (e) {
      print('Error adding profile: $e');
    }
  }

  // username으로 사용자 조회 메서드
  Future<DataSnapshot> getUserByUsername(String username) async {
    try {
      Query query = _databaseRef.orderByChild('username').equalTo(username);
      DataSnapshot snapshot = await query.get();
      return snapshot;
    } catch (e) {
      print('Error getting user by username: $e');
      rethrow;
    }
  }

  // 유저의 username과 해시된 비밀번호를 검증하는 메서드
  Future<User_Auth?> authenticateUser(String username, String hashedPassword) async {
    try {
      DataSnapshot snapshot = await getUserByUsername(username);
      if (snapshot.exists) {
        Map<String, dynamic> userData = Map<String, dynamic>.from((snapshot.value as Map).values.first);
        User_Auth user = User_Auth.fromJson(userData);
        if (user.hashedPassword == hashedPassword) {
          return user;
        }
      }
      return null;
    } catch (e) {
      print('Error authenticating user: $e');
      return null;
    }
  }
}
