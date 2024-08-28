import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/user_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _smsCodeController = TextEditingController();

  final UserService _userService = UserService();
  String _verificationId = '';

  void _registerAccount() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;
    final String p_num = _phoneController.text;

    String? result = await _userService.validateAndRegisterUser(username, password, confirmPassword, p_num);
    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('회원가입이 완료되었습니다.')),
      );
      Navigator.pop(context);
    }
  }

  void _checkUsernameDuplicate() async {
    final String username = _usernameController.text;
    String result = await _userService.checkUsernameDuplicate(username);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result)),
    );
  }

  void _verifyPhoneNumber() async {
    final String phoneNumber = _phoneController.text;
    final String formattedPhoneNumber = _formatPhoneNumber(phoneNumber);

    String? result = await _userService.verifyPhoneNumber(
      phoneNumber: formattedPhoneNumber,
      onCodeSent: (String verificationId) {
        setState(() {
          _verificationId = verificationId;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('SMS 코드가 전송되었습니다.')),
        );
      },
      onVerificationCompleted: (PhoneAuthCredential credential) async {
        await _userService.signInWithSmsCode(credential.smsCode!);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('전화번호 인증이 자동으로 완료되었습니다.')),
        );
      },
      onVerificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('전화번호 인증 실패: ${e.message}')),
        );
      },
    );

    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }

  void _signInWithSmsCode() async {
    final String smsCode = _smsCodeController.text;
    String? result = await _userService.signInWithSmsCode(smsCode);

    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('전화번호 인증이 완료되었습니다.')),
      );
    }
  }

  // 전화번호 포맷팅
  String _formatPhoneNumber(String phoneNumber) {
    // 예: 한국 번호: 010-1234-5678 -> +821012345678
    if (phoneNumber.startsWith('0')) {
      return '+82' + phoneNumber.substring(1).replaceAll('-', '');
    }
    return phoneNumber;
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
              _buildTextField(controller: _usernameController, label: '아이디', icon: Icons.perm_identity),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _checkUsernameDuplicate,
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
              const SizedBox(height: 16),
              _buildTextField(controller: _phoneController, label: '전화번호', icon: Icons.phone),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _verifyPhoneNumber,
                  child: const Text(
                    '전화번호 인증',
                    style: TextStyle(color: Color(0xFF537052)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(controller: _smsCodeController, label: 'SMS 코드', icon: Icons.sms),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _registerAccount,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF537052),
                ),
                child: const Text('회원가입'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label, required IconData icon, bool obscureText = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
      obscureText: obscureText,
    );
  }
}
