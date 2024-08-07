import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      // 구글 로그인 팝업
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // 사용자가 로그인 팝업을 닫은 경우
        return null;
      }

      // 구글에서 인증된 계정 정보를 받아옴
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // FirebaseAuth에 구글 인증 정보를 사용하여 로그인
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // FirebaseAuth에 로그인
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      // 성공적으로 로그인된 사용자 반환
      return userCredential.user;
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
