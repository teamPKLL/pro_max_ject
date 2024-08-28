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
    String hashedPassword = HashUtil.hashPassword(password);
    User_Auth? user = await _userRepository.authenticateUser(username, hashedPassword);

    if (user != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', user.id!);
      await prefs.setString('username', user.username);
      await prefs.setString('phoneNumber', user.p_num);
      await prefs.setBool('isLoggedIn', true);
      return null;
    } else {
      return '아이디 또는 비밀번호가 잘못되었습니다.';
    }
  }

  // 로그아웃
  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('username');
    await prefs.remove('isLoggedIn');
    await prefs.remove('phoneNumber');
  }

  // 전화번호 인증 시작
  Future<String?> verifyPhoneNumber({
    required String phoneNumber,
    required Function(String) onCodeSent,
    required Function(PhoneAuthCredential) onVerificationCompleted,
    required Function(FirebaseAuthException) onVerificationFailed,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: onVerificationCompleted,
        verificationFailed: onVerificationFailed,
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          onCodeSent(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
      return null;
    } catch (e) {
      return '전화번호 인증 요청 실패: ${e.toString()}';
    }
  }

  // SMS 코드로 인증 완료
  Future<String?> signInWithSmsCode(String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smsCode,
      );
      await _auth.signInWithCredential(credential);
      return null;
    } catch (e) {
      return 'SMS 코드가 올바르지 않습니다.';
    }
  }
}
