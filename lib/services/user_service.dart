import 'package:firebase_database/firebase_database.dart';

import '../repositories/user_repository.dart';
import '../models/user.dart';
import '../utils/hash_util.dart';

class UserService {
  final UserRepository _userRepository = UserRepository();

  // 사용자 등록 메서드
  Future<void> registerUser(User user) async {
    await _userRepository.addUser(user); // UserRepository를 통해 사용자를 데이터베이스에 추가
  }

  // ID 중복 확인 메서드
  Future<bool> isIdDuplicate(String id) async {
    DataSnapshot snapshot = await _userRepository.getUserById(id); // ID로 사용자 데이터 조회
    return snapshot.exists; // 사용자 데이터가 존재하면 true 반환
  }

  // 사용자 등록 및 유효성 검사 메서드
  Future<String?> validateAndRegisterUser(String name, String id, String password, String confirmPassword) async {
    if (password != confirmPassword) {
      return '비밀번호가 일치하지 않습니다.'; // 비밀번호 확인 실패 시 메시지 반환
    }

    bool isDuplicate = await isIdDuplicate(id); // ID 중복 확인
    if (isDuplicate) {
      return '이미 존재하는 아이디입니다.'; // 중복된 ID일 경우 메시지 반환
    }

    // 비밀번호 해시화
    String hashedPassword = HashUtil.hashPassword(password); // 비밀번호를 해시화
    User newUser = User(name: name, id: id, hashedPassword: hashedPassword); // 새로운 User 객체 생성
    await registerUser(newUser); // 사용자 등록
    return null; // 등록 성공 시 null 반환
  }

  // ID 중복 확인 및 메시지 반환 메서드
  Future<String> checkIdDuplicate(String id) async {
    bool isDuplicate = await isIdDuplicate(id); // ID 중복 확인
    return isDuplicate ? '이미 존재하는 아이디입니다.' : '사용 가능한 아이디입니다.'; // 결과에 따른 메시지 반환
  }
}
