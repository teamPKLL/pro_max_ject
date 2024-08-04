import 'package:flutter/material.dart';

void main() {
  runApp(const SignUp()); // 회원가입 창
}

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            '가입',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xEF537052),
          centerTitle: true,
          elevation: 4,
        ),
        backgroundColor: const Color(0xFFF0F1F0),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16), // AppBar와의 간격
                // 이름 입력 필드
                const TextField(
                  decoration: InputDecoration(
                    labelText: '이름',
                    fillColor: Color(0xFFD9DED9),
                    filled: true,
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 0, color: Color(0x07658064)),
                    ),
                  ),
                ),
                const SizedBox(height: 16), // 간격
                // 아이디 입력 필드
                const TextField(
                  decoration: InputDecoration(
                    labelText: '아이디',
                    fillColor: Color(0xFFD9DED9),
                    filled: true,
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.perm_identity),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 0, color: Color(0x07658064)),
                    ),
                  ),
                ),
                // 아이디 중복 확인 버튼
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // 아이디 중복 확인 로직 구현
                    },
                    child: const Text(
                      'ID 중복확인',
                      style: TextStyle(color: Color(0xFF537052)),
                    ),
                  ),
                ),
                const SizedBox(height: 16), // 간격
                // 비밀번호 입력 필드
                const TextField(
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    fillColor: Color(0xFFD9DED9),
                    filled: true,
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock_outline),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 0, color: Color(0x07658064)),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16), // 간격
                // 비밀번호 확인 필드
                const TextField(
                  decoration: InputDecoration(
                    labelText: '비밀번호 확인',
                    fillColor: Color(0xFFD9DED9),
                    filled: true,
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock_outline),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 0, color: Color(0x07658064)),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 24), // 버튼과 입력 필드 사이의 간격
                // 계정 생성 버튼
                ElevatedButton(
                  onPressed: () {
                    // 계정 생성 로직 구현
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xFF537052)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      '가입하기',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16), // 하단 여백
                TextButton(  // 비밀번호 찾기 버튼
                  onPressed: () {},
                  child: Text(
                    '로그인으로 돌아가기',
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
      ),
    );
  }
}
