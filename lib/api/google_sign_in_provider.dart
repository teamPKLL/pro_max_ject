import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleSignInProvider {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // 사용자가 로그인 팝업을 닫은 경우
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userName', user.displayName ?? '');
        await prefs.setString('userEmail', user.email ?? '');
        await prefs.setString('userPhone', '전화번호 제공되지 않음'); // 구글은 전화번호를 제공하지 않음
        await prefs.setString('userBirth', '생년월일 제공되지 않음'); // 구글은 생일을 제공하지 않음
        await prefs.setBool('isSocialLogin', true); // 소셜 로그인 여부를 true로 설정
      }

      return user;
    } catch (error) {
      print('Google 로그인 실패: $error');
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }
}
