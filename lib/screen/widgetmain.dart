import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pro_max_ject/main.dart';
import 'package:pro_max_ject/screen/map.dart';
import 'package:pro_max_ject/screen/myPage.dart';
import 'package:pro_max_ject/screen/reminder.dart';

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});
/////////////////// 메인 화면 ////////////////////
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        // scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: Main(),
      ),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _selectedIndex = 0; // 현재 선택된 인덱스

  final List<Widget> screens = [
    FigmaToCodeApp(),
    Reminder(),
    MapPage(),
    MyPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // 선택된 인덱스 업데이트
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          //////////////////////// 알림 아이콘 부분 ////////////////////////
          Container(
            width: double.infinity,
            height: 852,
            color: Color(0xFFF0F1F0),
            child: Stack(
              children: [
                Positioned(
                  left: 353,
                  top: 48,
                  child: InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.notifications,
                      color: Color(0xEF537052),
                    ),
                  ),
                ),

                //////////////////////// 상단 제목 ////////////////////////
                const Positioned(
                  left: 21,
                  top: 46,
                  child: Text(
                    '이재난녕',
                    style: TextStyle(
                      color: Color(0xFF415C40),
                      fontSize: 24,
                      fontFamily: 'BM_HANNA_TTF',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                //////////////////////// 1번째 공지부분 //////////////////////////
                Positioned(
                  left: 21,
                  top: 90,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 351,
                      height: 34,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                //////////////////////// 재해 방안(큰 2번째 목록) ////////////////////////
                Positioned(
                  left: 21,
                  top: 138,
                  child: InkWell(
                    onTap: () {}, // 버튼구현
                    child: Container(
                      width: 351,
                      height: 147,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                //////////////////////// 지도 위치 ////////////////////////
                Positioned(
                  left: 21,
                  top: 300,
                  child: InkWell(
                    onTap: () {

                    }, // 버튼
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: ShapeDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.00, -1.00),
                          end: Alignment(0, 1),
                          colors: [Colors.white, Colors.white],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(43),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                //////////////////////// sos 위치 ////////////////////////
                Positioned(
                  left: 205,
                  top: 300,
                  child: InkWell(
                    onTap: () {}, // 버튼 클릭하는 부분
                    child: Container(
                      // SOS 버튼
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.00, -1.00),
                          end: Alignment(0, 1),
                          colors: [Color(0xFFFDD8C3), Color(0xFFFF8873)],
                        ),
                        borderRadius: BorderRadius.circular(43),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(43),
                        child: Image.asset(
                          'assets/sos_button.png',
                          fit: BoxFit.cover, // 이미지 크기와 위치 조절
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: -465,
                  top: 1211,
                  child: Container(
                    width: 677.17,
                    height: 677.17,
                    decoration: ShapeDecoration(
                      shape: OvalBorder(
                        side: BorderSide(
                          width: 2.21,
                          color: Colors.white.withOpacity(0.800000011920929),
                        ),
                      ),
                    ),
                  ),
                ),

                // 2번째 공지부분? 너무 많아서 일단 삭제
                // Positioned(
                //   left: 21,
                //   top: 137,
                //   child: Container(
                //     width: 351,
                //     height: 34,
                //     decoration: ShapeDecoration(
                //       color: Colors.white,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(43),
                //       ),
                //       shadows: [
                //         BoxShadow(
                //           color: Color(0x3F000000),
                //           blurRadius: 4,
                //           offset: Offset(0, 4),
                //           spreadRadius: 0,
                //         )
                //       ],
                //     ),
                //   ),
                // ),

                //////////////////////// 알림목록 1 ////////////////////////
                Positioned(
                  left: 30,
                  top: 480,
                  child: Container(
                    width: 331,
                    height: 73,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x30000000),
                          blurRadius: 4,
                          offset: Offset(0, 5),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: InkWell(
                      onTap: () {}, // 버튼 구현
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '폭염주의보 지속 발효 중. 부모님께 안부전화드리기, 야외활동 자제, 폭염 안전 수칙(물, 그늘, 휴식) 준수 등 건강관리에 유의 바랍니다. [인천광역시]',
                          style: TextStyle(
                            color: Color(0xFF24252C),
                            fontSize: 11,
                            fontFamily: 'Lexend Deca',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                //////////////////////// 알림목록 2 ////////////////////////
                Positioned(
                  left: 30,
                  top: 573,
                  child: Container(
                    width: 331,
                    height: 73,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x30000000),
                          blurRadius: 4,
                          offset: Offset(0, 5),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: InkWell(
                      onTap: () {}, // 버튼 구현
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '폭염주의보 지속 발효 중. 부모님께 안부전화드리기, 야외활동 자제, 폭염 안전 수칙(물, 그늘, 휴식) 준수 등 건강관리에 유의 바랍니다. [인천광역시]',
                          style: TextStyle(
                            color: Color(0xFF24252C),
                            fontSize: 11,
                            fontFamily: 'Lexend Deca',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                ///////////////////// 뭔지 모르는 부분 ////////////////////
                Positioned(
                  left: 331,
                  top: 716,
                  child: Transform(
                    transform: Matrix4.identity()..rotateZ(-1.56),
                    child: Container(
                      width: 24,
                      height: 24,
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 7),
                      child: Center(
                        child: Container(),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 334,
                  top: 600,
                  child: Transform(
                    transform: Matrix4.identity()..rotateZ(-1.56),
                    child: Container(
                      width: 24,
                      height: 24,
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 7),
                      child: Center(
                        child: Container(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // /////////////////// 하단 네비게이션 바 부분 ///////////////////////
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.white, // 하단 네비게이션 바의 배경색
      //   selectedItemColor: Color(0xEF537052), // 선택된 아이템의 색상
      //   unselectedItemColor: Colors.grey, // 선택되지 않은 아이템의 색상
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: '홈',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.search),
      //       label: '검색',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.menu),
      //       label: '메뉴',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: '마이페이지',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   // onTap: _onItemTapped,
      //   onTap: (index) {
      //     setState(() {
      //       _selectedIndex = index;
      //     });
      //   },
      // ),
    );
  }
}
