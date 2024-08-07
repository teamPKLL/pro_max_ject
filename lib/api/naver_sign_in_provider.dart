import 'package:flutter_naver_login/flutter_naver_login.dart';

class NaverSignInProvider {
  // 네이버 로그인
  Future<NaverLoginResult> signInWithNaver() async {
    try {
      final result = await FlutterNaverLogin.logIn();
      return result;
    } catch (e) {
      throw Exception('Naver 로그인 오류: $e');
    }
  }

  // 현재 로그인 상태 확인
  Future<bool> isLoggedIn() async {
    return await FlutterNaverLogin.isLoggedIn;
  }

  // 현재 로그인된 사용자 정보 가져오기
  Future<NaverAccountResult> getCurrentAccount() async {
    return await FlutterNaverLogin.currentAccount();
  }

  // 로그아웃
  Future<void> logOut() async {
    await FlutterNaverLogin.logOut();
  }

  // 로그아웃 및 토큰 삭제
  Future<void> logOutAndDeleteToken() async {
    await FlutterNaverLogin.logOutAndDeleteToken();
  }
}
