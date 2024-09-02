import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NaverSignInProvider {
  Future<NaverLoginResult> signInWithNaver() async {
    try {
      final result = await FlutterNaverLogin.logIn();
      if (result.status == NaverLoginStatus.loggedIn) {
        final user = result.account;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userName', user.name ?? '');
        await prefs.setString('userEmail', user.email ?? '');
        await prefs.setString('userBirth', user.birthday ?? '');
        await prefs.setString('userPhone', user.mobile ?? '');
        await prefs.setBool('isSocialLogin', true); // 소셜 로그인 여부를 true로 설정
      }
      return result;
    } catch (e) {
      throw Exception('Naver login error: $e');
    }
  }

  Future<bool> isLoggedIn() async {
    return await FlutterNaverLogin.isLoggedIn;
  }

  Future<NaverAccountResult> getCurrentAccount() async {
    return await FlutterNaverLogin.currentAccount();
  }

  Future<void> logOut() async {
    await FlutterNaverLogin.logOut();
  }

  Future<void> logOutAndDeleteToken() async {
    await FlutterNaverLogin.logOutAndDeleteToken();
  }
}
