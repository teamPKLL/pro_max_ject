import 'package:flutter/material.dart';
import 'package:pro_max_ject/main.dart';
import 'signup.dart';

class ForGot extends StatelessWidget {
  const ForGot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
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
            bottom: TabBar(
              unselectedLabelColor: Colors.black,
              labelColor: Colors.white,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                // color: Colors.white,
              ),
              tabs: [
                Tab(
                  child: Text(
                    '아이디 찾기',
                  ),
                ),
                Tab(text: '비밀번호 찾기'),
              ],
            ),
          ),
          backgroundColor: const Color(0xFFF0F1F0),
          body: TabBarView(
            children: [
              // 아이디 찾기 탭
              _buildFindIdTab(),
              // 비밀번호 찾기 탭
              _buildFindPasswordTab(),
            ],
          ),
        ),
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
                  '아이디 찾기',
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

  // Widget for 비밀번호 찾기 탭
  Widget _buildFindPasswordTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: '이메일',
                fillColor: Color(0xFFD9DED9),
                filled: true,
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(width: 0, color: Color(0x07658064)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // 이메일 인증 전송 로직 구현
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xFF537052)),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  '이메일 인증 전송',
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
