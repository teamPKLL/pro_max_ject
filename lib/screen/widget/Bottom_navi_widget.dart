import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro_max_ject/screen/sos.dart';
import 'package:provider/provider.dart';

import '../map.dart';
import '../user_page/myPage.dart';
import '../reminder.dart';
import '../widgetmain.dart';
import 'IndexProvider.dart';

class MainScreen extends StatefulWidget { // bottomNavigationBar로 이동하기.
  final int initialIndex;

  const MainScreen({super.key, this.initialIndex = 0}); // map.dart에서 인덱스 설정 해보려고 변경함. 오류시 아래 주석 풀기.
  // const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  final List<Widget> screens = [
    MapPage(),         // 지도 페이지
    FigmaToCodeApp(),  // main 페이지
    Reminder(),        // 알림 페이지
    MyPage(),          // 프로필 페이지
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = context.watch<IndexProvider>().selectedIndex;
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