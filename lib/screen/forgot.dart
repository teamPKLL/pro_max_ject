import 'package:flutter/material.dart';
import 'package:pro_max_ject/screen/login_screen.dart';

class ForGot extends StatelessWidget {
  const ForGot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            '회원 정보 찾기',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'BM_HANNA_TTF',
            ),
          ),
          backgroundColor: const Color(0xEF537052),
          centerTitle: true,
          elevation: 4,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ),
        backgroundColor: const Color(0xFFF0F1F0),
        body: _buildFindIdTab(), // 이 부분에서 단일 탭 화면을 사용합니다.
      ),
    );
  }

  // Widget for 아이디 찾기 탭
  Widget _buildFindIdTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: '전화번호',
                fillColor: Color(0xFFD9DED9),
                filled: true,
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(width: 0, color: Color(0x07658064)),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // 아이디 찾기 로직 구현
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xFF537052)),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  '아이디 및 비빌번호 찾기',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
