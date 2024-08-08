import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:pro_max_ject/screen/login_screen.dart';
import 'package:pro_max_ject/screen/map.dart';
import 'package:pro_max_ject/screen/myPage.dart';
import 'package:pro_max_ject/screen/reminder.dart';
import 'package:pro_max_ject/screen/signup.dart';
import 'package:pro_max_ject/screen/widgetmain.dart';
import 'package:pro_max_ject/screen/phone_verification.dart';

import 'firebase_options.dart';

Future<void> main() async {
  // Flutter 엔진을 초기화
  WidgetsFlutterBinding.ensureInitialized();

  // Kakao SDK 초기화
  KakaoSdk.init(
    nativeAppKey: 'c16c44bd57bcaf0c1b866cb6bd1ce937',
    javaScriptAppKey: '8bc1ee40ec3a8a422d71fb1956f0ebf7',
  );

  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // runApp(MyApp());
  runApp(const PhoneVerification());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUp(),
        '/main': (context) => MainScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget { // bottomNavigationBar로 이동하기.
  final int initialIndex;

  const MainScreen({super.key, this.initialIndex = 0}); // map.dart에서 인덱스 설정 해보려고 변경함. 오류시 아래 주석 풀기.
  // const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; // 초기화.
  }

  final List<Widget> screens = [
    FigmaToCodeApp(),  // main 페이지
    Reminder(),        // 검색 페이지 들어가야 함.
    MapPage(),         // 지도 페이지
    MyPage(),          // 프로필 페이지
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xEF537052),
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
