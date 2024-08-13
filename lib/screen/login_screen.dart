import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:pro_max_ject/main.dart';
import '../api/google_sign_in_provider.dart';
import '../api/naver_sign_in_provider.dart';
import '../api/kakao_login.dart';
import '../api/main_view_model.dart';
import '../services/user_service.dart'; // UserService를 import합니다.

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final viewModel = MainViewModel(KakaoLogin()); // 카카오톡 로그인 구현
final UserService _userService = UserService(); // UserService 인스턴스 생성

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    String id = _idController.text;
    String password = _passwordController.text;

    String? loginResult = await _userService.loginUser(id, password);
    if (loginResult == null) {
      Navigator.pushReplacementNamed(context, '/main');
    } else {
      // 로그인 실패 메시지를 사용자에게 표시합니다.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loginResult)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 삼각형 추가로 하면 좋을듯
        // 맨 위 바
        backgroundColor: Color(0xEF537052),
        centerTitle: true,
        elevation: 15,
        toolbarHeight: 180.0, // AppBar의 높이 설정
      ),
      backgroundColor: Color(0xFFF0F1F0),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 150), // AppBar와의 간격
              TextField(
                controller: _idController,
                decoration: InputDecoration(
                  labelText: 'ID',
                  // 아이디 칸
                  fillColor: Color(0xFFD9DED9),
                  filled: true,
                  border: OutlineInputBorder(),
                  // 칸 테두리
                  prefixIcon: Icon(Icons.perm_identity),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                    BorderSide(width: 0, color: Color(0x07658064)),
                  ),
                ),
              ),
              SizedBox(height: 16), // 조금 간격
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  // 비밀번호
                  fillColor: Color(0xFFD9DED9),
                  filled: true,
                  border: OutlineInputBorder(),
                  // 테두리
                  prefixIcon: Icon(Icons.lock_outline),
                  // 아이콘
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                    BorderSide(width: 0, color: Color(0x07658064)),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login, // 로그인 버튼을 누르면 _login 메서드를 호출합니다.
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(Color(0xFF537052)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24), // 버튼과 이미지 사이의 간격
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () async { // 첫 번째 원형 버튼 클릭 동작
                        print('구글 로그인 누름');
                        final user = await GoogleSignInProvider().signInWithGoogle();
                        if (user != null) {
                          print('Google 로그인 성공: ${user.displayName}');
                          Navigator.pushReplacementNamed(context, '/main');
                        }
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/Google logo.png'),
                      ),
                    ),
                    TextButton(
                      onPressed: () async { // 두 번째 원형 버튼 클릭 동작
                        print('Naver 로그인버튼 누름');
                        final result = await NaverSignInProvider().signInWithNaver();
                        if (result.status == NaverLoginStatus.loggedIn) {
                          print('Naver 로그인 성공: ${result.account.name}');
                          Navigator.pushReplacementNamed(context, '/main');
                        } else {
                          print('Naver 로그인 실패: ${result.errorMessage}');
                        }
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/naver.png'),
                      ),
                    ),
                    TextButton(
                      onPressed: () async { // 세 번째 원형 버튼 클릭 동작
                        print('카톡로그인버튼 누름');
                        await viewModel.login(); // 카카오톡 로그인 연동
                        if (viewModel.isLogined) {  // 로그인 성공시 main 페이지로 이동.
                          Navigator.pushReplacementNamed(context, '/main');
                        } else {
                          print('접근이 허용되지 않았습니다.');
                        }
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/kakao.png'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              TextButton(  // 비밀번호 찾기 버튼
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => ForGot()),
                  // );
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                    color: Color(0xEF537052),
                  ),
                ),
              ),
              SizedBox(height: 8),
              TextButton(  // 가입 버튼
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                    color: Color(0xEF537052),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
