import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(  // 삼각형 추가로 하면 좋을듯
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
                    backgroundColor: MaterialStateProperty.all(Color(0xFF537052)),
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
                      GestureDetector(
                        onTap: () {
                          // 첫 번째 원형 버튼 클릭 동작
                          print('First button tapped');
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Color(0xEF537052),
                          backgroundImage: AssetImage('assets/Google logo.png'),
                        ),
                      ),
                      // SizedBox(height: 100),
                      GestureDetector(
                        onTap: () {
                          // 두 번째 원형 버튼 클릭 동작
                          print('Second button tapped');
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Color(0xEF537052),
                          backgroundImage: AssetImage('assets/Facbook.png'),
                        ),
                      ),
                      // SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          // 세 번째 원형 버튼 클릭 동작
                          print('Third button tapped');
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Color(0xEF537052),
                          backgroundImage: AssetImage('assets/kakao.png'),
                        ),
                      ),
                    ],
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