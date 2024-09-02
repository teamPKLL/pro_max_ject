import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pro_max_ject/screen/user_page/contactUs.dart';

class SocialMyPage extends StatefulWidget {
  @override
  _SocialMyPageState createState() => _SocialMyPageState();
}

class _SocialMyPageState extends State<SocialMyPage> {
  late Future<String?> _userNameFuture;
  late Future<String?> _userEmailFuture;
  late Future<String?> _userBirthFuture;
  late Future<String?> _userPhoneFuture;

  @override
  void initState() {
    super.initState();
    _userNameFuture = _getUserName();
    _userEmailFuture = _getUserEmail();
    _userBirthFuture = _getUserBirth();
    _userPhoneFuture = _getUserPhone();
  }

  Future<String?> _getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName');
  }

  Future<String?> _getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userEmail');
  }

  Future<String?> _getUserBirth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userBirth');
  }

  Future<String?> _getUserPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userPhone');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F1F0),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          '마이페이지',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'BM_HANNA_TTF',
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xEF537052),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<String?>(
                future: _userNameFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Center(child: Text('No user data found'));
                  } else {
                    return Row(
                      children: [
                        Text(
                          snapshot.data!,
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                        ),
                        Text(
                          ' 님 환영합니다!',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                        ),
                      ],
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              ContentBox(
                children: [
                  FutureBuilder<String?>(
                    future: _userNameFuture,
                    builder: (context, snapshot) {
                      return ContentIconRow(
                        icon: Icon(Icons.account_circle),
                        text: snapshot.data ?? '이름 없음',
                      );
                    },
                  ),
                  FutureBuilder<String?>(
                    future: _userBirthFuture,
                    builder: (context, snapshot) {
                      return ContentIconRow(
                        icon: Icon(Icons.cake_outlined),
                        text: snapshot.data ?? '생일 없음',
                      );
                    },
                  ),
                  FutureBuilder<String?>(
                    future: _userEmailFuture,
                    builder: (context, snapshot) {
                      return ContentIconRow(
                        icon: Icon(Icons.email_outlined),
                        text: snapshot.data ?? '이메일 없음',
                      );
                    },
                  ),
                  FutureBuilder<String?>(
                    future: _userPhoneFuture,
                    builder: (context, snapshot) {
                      return ContentIconRow(
                        icon: Icon(Icons.phone),
                        text: snapshot.data ?? '전화번호 없음',
                      );
                    },
                  ),
                ],
              ),
              ContentBox(
                children: [
                  ContentIconRow(
                    icon: Icon(Icons.textsms_outlined),
                    text: "개발자 연락처",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ContactUsPage()),
                      );
                    },
                  ),
                ],
              ),
              ContentBox(
                children: [
                  ContentIconRow(
                    icon: Icon(Icons.logout_outlined, color: Colors.red),
                    text: "로그 아웃",
                    onTap: () async {
                      await _logoutUser();
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // 모든 사용자 정보 삭제
    // 로그아웃 로직 추가 (예: 소셜 로그아웃 처리)
  }
}

class ContentBox extends StatelessWidget {
  final List<Widget> children;

  const ContentBox({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 351,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(15),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }
}

class ContentIconRow extends StatelessWidget {
  final String text;
  final Icon icon;
  final String? description;
  final VoidCallback? onTap;

  const ContentIconRow({super.key, required this.icon, required this.text, this.description, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            child: icon,
          ),
          Expanded(child: Text(text)),
          if (description != null) ...[
            Container(
              padding: EdgeInsets.all(5),
              child: Text(description!, style: const TextStyle(color: Colors.blue)),
            ),
          ],
        ],
      ),
    );
  }
}
