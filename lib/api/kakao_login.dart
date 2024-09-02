import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:pro_max_ject/api/social_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KakaoLogin implements SocialLogin {
  @override
  Future<bool> login() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      if (isInstalled) {
        try {
          // 카카오톡을 통한 로그인 시도
          await UserApi.instance.loginWithKakaoTalk();
          print("카카오톡으로 로그인 성공");
        } catch (e) {
          print("카카오톡으로 로그인 실패: $e");
          return false;
        }
      } else {
        try {
          // 카카오 계정으로 로그인 시도
          await UserApi.instance.loginWithKakaoAccount();
          print("카카오 계정으로 로그인 성공");
        } catch (e) {
          print("카카오 계정으로 로그인 실패: $e");
          return false;
        }
      }

      // 로그인 후 사용자 정보 가져오기
      final user = await UserApi.instance.me();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isSocialLogin', true); // 소셜 로그인 여부를 true로 설정
      // 사용자 정보 저장
      await prefs.setString('userName', user.kakaoAccount?.profile?.nickname ?? '');
      await prefs.setString('userEmail', user.kakaoAccount?.email ?? '');
      await prefs.setString('userBirth', user.kakaoAccount?.birthday ?? '');
      await prefs.setString('userPhone', '전화번호 제공되지 않음'); // 카카오는 전화번호를 제공하지 않음

      return true;
    } catch (e) {
      print("카카오 로그인 중 오류 발생: $e");
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await UserApi.instance.unlink();
      print("카카오 로그아웃 성공");
      return true;
    } catch (error) {
      print("카카오 로그아웃 실패: $error");
      return false;
    }
  }
}
