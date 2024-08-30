import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pro_max_ject/models/user.dart';
import 'package:pro_max_ject/models/user_profile.dart';
import '../repositories/user_repository.dart';
import '../services/profile_service.dart';
import '../utils/hash_util.dart';

class UserService {
  final UserRepository _userRepository = UserRepository();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = '';

  // 사용자 등록 메서드
  Future<void> registerUser(User_Auth user) async {
    await _userRepository.addUser(user);
  }

  // 사용자 이름 중복 확인
  Future<bool> isUsernameDuplicate(String username) async {
    DataSnapshot snapshot = await _userRepository.getUserByUsername(username);
    return snapshot.exists;
  }

  // 사용자 등록 및 유효성 검사
  Future<String?> validateAndRegisterUser(String username, String password, String confirmPassword, String p_num) async {
    if (password != confirmPassword) {
      return '비밀번호가 일치하지 않습니다.';
    }

    bool isDuplicate = await isUsernameDuplicate(username);
    if (isDuplicate) {
      return '이미 존재하는 아이디입니다.';
    }

    String hashedPassword = HashUtil.hashPassword(password);
    User_Auth newUser = User_Auth(username: username, hashedPassword: hashedPassword, p_num: p_num);
    await registerUser(newUser);
    return null;
  }

  // 사용자 이름 중복 확인 및 메시지 반환
  Future<String> checkUsernameDuplicate(String username) async {
    bool isDuplicate = await isUsernameDuplicate(username);
    return isDuplicate ? '이미 존재하는 아이디입니다.' : '사용 가능한 아이디입니다.';
  }

  // 로그인 시 유저 인증
  Future<String?> loginUser(String username, String password) async {
    // 입력된 비밀번호를 해시화
    String hashedPassword = HashUtil.hashPassword(password);

    // 사용자 인증 시도
    User_Auth? user = await _userRepository.authenticateUser(username, hashedPassword);

    if (user != null) {
      // 로그인 성공 시, SharedPreferences에 사용자 정보 저장
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', user.id!);
      await prefs.setString('username', user.username);
      await prefs.setString('phoneNumber', user.p_num);
      await prefs.setBool('isLoggedIn', true);
      await prefs.setBool('isAdmin', user.isAdmin); // isAdmin 필드 추가

      return null; // 성공 시 에러 메시지 없음
    } else {
      return '아이디 또는 비밀번호가 잘못되었습니다.'; // 로그인 실패 메시지
    }
  }

  // 로그아웃
  Future<void> logoutUser() async {
    // 로그아웃 시, SharedPreferences에 저장된 사용자 정보 삭제
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('username');
    await prefs.remove('phoneNumber');
    await prefs.remove('isLoggedIn');
    await prefs.remove('isAdmin'); // isAdmin 필드도 삭제
  }


  Future<String?> verifyPhoneNumber({
    required String phoneNumber,
    required Function(String verificationId, int? resendToken) onCodeSent,
    required Function(PhoneAuthCredential credential) onVerificationCompleted,
    required Function(FirebaseAuthException e) onVerificationFailed,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: onVerificationCompleted,
        verificationFailed: onVerificationFailed,
        codeSent: onCodeSent,
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      return 'Phone number verification failed: $e';
    }
    return null;
  }

  Future<String?> signInWithSmsCode(String verificationId, String smsCode) async {
    try {
      final credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
      final UserCredential authCredential = await _auth.signInWithCredential(credential);
      if (authCredential.user != null) {
        // Sign-in successful
        return null;
      } else {
        return 'Sign-in failed';
      }
    } catch (e) {
      return 'Sign-in with SMS code failed: $e';
    }
  }
}
