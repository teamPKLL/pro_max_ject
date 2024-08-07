import 'package:flutter/material.dart';
import '../services/user_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // 텍스트 필드 컨트롤러
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // 사용자 서비스 인스턴스
  final UserService _userService = UserService();

  // 회원가입 처리 메서드
  void _registerAccount() async {
    final String name = _nameController.text;
    final String id = _idController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    // 사용자 정보 검증 및 등록
    String? result = await _userService.validateAndRegisterUser(name, id, password, confirmPassword);
    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)), // 에러 메시지 표시
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('회원가입이 완료되었습니다.')), // 성공 메시지 표시
      );
      Navigator.pop(context); // 회원가입 완료 후 로그인 화면으로 돌아가기
    }
  }

  // ID 중복 확인 메서드
  void _checkIdDuplicate() async {
    final String id = _idController.text;
    String result = await _userService.checkIdDuplicate(id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result)), // ID 중복 확인 결과 표시
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('가입'),
        backgroundColor: const Color(0xEF537052),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              _buildTextField(controller: _nameController, label: '이름', icon: Icons.person),
              const SizedBox(height: 16),
              _buildTextField(controller: _idController, label: '아이디', icon: Icons.perm_identity),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _checkIdDuplicate, // ID 중복 확인 버튼
                  child: const Text(
                    'ID 중복확인',
                    style: TextStyle(color: Color(0xFF537052)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(controller: _passwordController, label: '비밀번호', icon: Icons.lock_outline, obscureText: true),
              const SizedBox(height: 16),
              _buildTextField(controller: _confirmPasswordController, label: '비밀번호 확인', icon: Icons.lock_outline, obscureText: true),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _registerAccount, // 회원가입 버튼
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xFF537052)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    '가입하기',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // 로그인 화면으로 돌아가기
                },
                child: const Text(
                  '로그인으로 돌아가기',
                  style: TextStyle(fontSize: 16, decoration: TextDecoration.underline, fontWeight: FontWeight.bold, color: Color(0xEF537052)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 텍스트 필드 위젯 빌더
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        fillColor: const Color(0xFFD9DED9),
        filled: true,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(width: 0, color: Color(0x07658064)),
        ),
      ),
      obscureText: obscureText,
    );
  }
}
