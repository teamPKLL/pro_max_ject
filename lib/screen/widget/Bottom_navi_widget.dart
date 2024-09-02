import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro_max_ject/screen/sos.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../map.dart';
import '../user_page/myPage.dart';
import '../reminder.dart';
import '../widgetmain.dart';
import 'IndexProvider.dart';
import '../user_page/socialMyPage.dart'; // SocialMyPage import 추가

class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({super.key, this.initialIndex = 0});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isSocialLogin = false; // 소셜 로그인 상태를 저장할 변수 추가

  @override
  void initState() {
    super.initState();
    _checkSocialLoginStatus(); // 초기화 시 소셜 로그인 상태 확인
  }

  Future<void> _checkSocialLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSocialLogin = prefs.getBool('isSocialLogin') ?? false; // 소셜 로그인 상태 불러오기
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = context.watch<IndexProvider>().selectedIndex;

    final List<Widget> screens = [
      MapPage(),
      FigmaToCodeApp(),
      Reminder(),
      isSocialLogin ? SocialMyPage() : MyPage(), // 소셜 로그인 상태에 따라 페이지 변경
    ];

    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xEF537052),
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map_rounded),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            context.read<IndexProvider>().setIndex(index);
          });
        },
      ),
    );
  }
}
