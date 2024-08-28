import 'package:flutter/material.dart';
import 'package:pro_max_ject/models/user_profile.dart'; // Profile 모델
import 'package:pro_max_ject/services/profile_service.dart'; // ProfileService 서비스

class MyProfile extends StatefulWidget {
  final String userId; // 로그인된 사용자 ID를 전달

  const MyProfile({super.key, required this.userId}); // 생성자 수정

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  late Future<Profile?> _profileFuture;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _birthController;

  final ProfileService _profileService = ProfileService();

  @override
  void initState() {
    super.initState();
    _profileFuture = _profileService.getProfileByUserId(widget.userId);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _birthController.dispose();
    super.dispose();
  }

  void _saveProfile() async {
    try {
      final profile = Profile(
        user_id: widget.userId,
        name: _nameController.text,
        email: _emailController.text,
        birth: _birthController.text,
      );
      await _profileService.updateProfile(profile);
      Navigator.pop(context);
    } catch (e) {
      print('Error saving profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '프로필',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'BM_HANNA_TTF',
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xEF537052),
          elevation: 4,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: FutureBuilder<Profile?>(
          future: _profileFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error loading profile'));
            }
            final profile = snapshot.data;

            // 초기화 후만 `TextEditingController`를 사용
            _nameController = TextEditingController(text: profile?.name ?? '');
            _emailController = TextEditingController(text: profile?.email ?? '');
            _birthController = TextEditingController(text: profile?.birth ?? '');

            return Container(
              color: const Color(0xFFF0F1F0),
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text(
                          '회원 정보',
                          style: TextStyle(
                            fontFamily: 'BM_HANNA_TTF',
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InputBox(
                    labelText: '이름',
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                  ),
                  InputBox(
                    labelText: '이메일',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'example@example.com',
                  ),
                  InputBox(
                    labelText: '생년월일',
                    controller: _birthController,
                    keyboardType: TextInputType.datetime,
                    hintText: 'YYYY-MM-DD',
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text("※ 위 개인정보는 구조 신호를 보낼 때 더 빠른 구조와 신원 확인을 위해 사용됩니다."),
                  ),
                  TextBtn(
                    text: '완료',
                    onPressed: _saveProfile,
                    theme: true,
                  ),
                  TextBtn(
                    text: '취소',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class InputBox extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final String? hintText;
  final TextInputType keyboardType;

  const InputBox({
    super.key,
    required this.labelText,
    this.controller,
    this.hintText,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Color(0xFF537052),
              width: 2.0,
            ),
          ),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.grey),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[600]),
          floatingLabelStyle: const TextStyle(
            color: Color(0xFF537052),
          ),
        ),
        cursorColor: Colors.black,
      ),
    );
  }
}

class TextBtn extends StatelessWidget {
  final String text;
  final bool theme;
  final VoidCallback onPressed;

  const TextBtn({
    super.key,
    required this.text,
    required this.onPressed,
    this.theme = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: theme ? const Color(0xFF537052) : const Color(0xFFF0F1F0),
        border: Border.all(
          color: const Color(0xFF537052),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: theme ? Colors.white : const Color(0xFF537052),
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
