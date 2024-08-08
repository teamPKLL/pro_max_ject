import 'package:flutter/material.dart';

class PhoneVerification extends StatefulWidget {
  const PhoneVerification({super.key});

  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  bool _isCodeSent = false; // 인증번호 전송 상태를 추적

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            '전화번호 인증',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'BM_HANNA_TTF',
            ),
          ),
          backgroundColor: const Color(0xEF537052),
          centerTitle: true,
          elevation: 4,
        ),
        backgroundColor: const Color(0xFFF0F1F0),
        body: _buildPhoneVerificationTab(),
      ),
    );
  }

  Widget _buildPhoneVerificationTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            TextField(
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
            if (_isCodeSent) ...[
              TextField(
                decoration: InputDecoration(
                  labelText: '인증번호',
                  fillColor: Color(0xFFD9DED9),
                  filled: true,
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.verified_user_outlined),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 0, color: Color(0x07658064)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // 인증번호 확인 로직 구현
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xFF537052)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    '인증 확인',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // 인증번호 재전송 로직 구현
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xFF537052)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    '인증번호 재전송',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ] else ...[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isCodeSent = true; // 인증번호 전송 버튼 클릭 시 상태 변경
                  });
                  // 전화번호 인증 로직 구현
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xFF537052)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    '인증번호 전송',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

