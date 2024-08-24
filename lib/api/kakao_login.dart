import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:pro_max_ject/api/social_login.dart';

class KakaoLogin implements SocialLogin {
  @override
  Future<bool> login() async {
    try {
      bool isIntalled = await isKakaoTalkInstalled();
      if (isIntalled) {
        try {
          await UserApi.instance.loginWithKakaoTalk();
          print("성공");
          return true;
        } catch (e) {
          print("실패라능.. $e");
          return false;
        }
      } else {
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print("어카운트 성공");
          return true;
        } catch (e) {
          print('실패.. $e');
          return false;
        }
      }
    } catch (e) {
      print("실패   $e");
      return false;
    }
  }

  @override
  Future<bool> logout() async{
    try{
      await UserApi.instance.unlink();
      return true;
    } catch (error) {
      return false;
    }
  }

// Future<void> kakaoLogin() async {
//
// try {
//   // 카카오톡으로 로그인 시도
//   if (await isKakaoTalkInstalled()) {
//     try {
//       await UserApi.instance.loginWithKakaoTalk();
//       print('카카오톡으로 로그인 성공');
//     } catch (e) {
//       print('카카오톡으로 로그인 실패: $e');
//       // 카카오톡 로그인이 실패하면, 카카오 계정으로 로그인 시도
//       await UserApi.instance.loginWithKakaoAccount();
//       print('카카오 계정으로 로그인 성공');
//     }
//   } else {
//     // 카카오톡이 설치되어 있지 않으면, 카카오 계정으로 로그인 시도
//     await UserApi.instance.loginWithKakaoAccount();
//     print('카카오 계정으로 로그인 성공');
//   }
//
//   // 사용자 정보 가져오기
//   User user = await UserApi.instance.me();
//   print('사용자 정보: ${user.kakaoAccount?.profile?.nickname}');
// } catch (e) {
//   print('로그인 실패: $e');
// }
// }

}