import 'package:flutter/material.dart';
import 'package:pro_max_ject/map.dart';
import 'package:pro_max_ject/reminder.dart';
import 'package:pro_max_ject/signup.dart';
import 'package:pro_max_ject/widgetmain.dart';
import 'package:pro_max_ject/forgot.dart';
import 'package:pro_max_ject/reminder.dart';
import 'package:pro_max_ject/faq.dart';

void main() {
  // runApp(const MyApp()); //로그인 창
  // runApp(const SignUp()); // 가입 창
  // runApp(MapPage());  // 맵 페이지
  // runApp(const FigmaToCodeApp()); // 메인화면
  // runApp(const ForGot());  // 아이디 비번 찾는창
  // runApp(const ReminderList());  // 알림 페이지
  runApp(const FAQList()); // FAQ
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                const TextField(
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
                const TextField(
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
                  onPressed: () {},
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
                        onPressed: () { // 첫 번째 원형 버튼 클릭 동작
                          print('구글 로그인 누름');
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage('assets/Google logo.png'),
                        ),
                      ),
                      // SizedBox(height: 100),
                      TextButton(
                        onPressed: () { // 두 번째 원형 버튼 클릭 동작
                          print('페북로그인버튼 누름');
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage('assets/Facbook.png'),
                        ),
                      ),
                      // SizedBox(height: 16),
                      TextButton(
                        onPressed: () { // 세 번째 원형 버튼 클릭 동작
                          print('카톡로그인버튼 누름');
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const SignUp()),
                    // );
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
      ),
    );
  }
}
