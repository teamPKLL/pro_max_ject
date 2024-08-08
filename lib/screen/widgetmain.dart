import 'package:flutter/material.dart';

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Color(0xFFF0F1F0),
        child: Column(
          children: [
            //////////////////////// 상단 바 ////////////////////////
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20), // 상단 바 여백
              child: Row(
                children: [
                  Text(
                    '이재난녕',
                    style: TextStyle(
                      color: Color(0xFF415C40),
                      fontSize: 24,
                      fontFamily: 'BM_HANNA_TTF',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(), // Spacer를 사용하여 아이콘을 오른쪽 끝으로 밀어냄
                  InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.notifications,
                      color: Color(0xEF537052),
                    ),
                  ),
                ],
              ),
            ),

            //////////////////////// 1번째 공지부분 //////////////////////////
            InkWell(
              onTap: () {},
              child: Container(
                width: double.infinity,
                height: 34,
                margin: EdgeInsets.symmetric(horizontal: 16),
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

            SizedBox(height: 16),

            //////////////////////// 재해 방안(큰 2번째 목록) ////////////////////////
            InkWell(
              onTap: () {},
              child: Container(
                width: double.infinity,
                height: 147,
                margin: EdgeInsets.symmetric(horizontal: 16),
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

            SizedBox(height: 16),

            //////////////////////// 지도 위치와 SOS 위치 ////////////////////////
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 중앙 정렬
              children: [
                SizedBox(width: 16), // 왼쪽 여백
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45), // 둥글게 설정
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
                SizedBox(width: 16), // 버튼 간격
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Color(0xFFFDD8C3), Color(0xFFFF8873)],
                      ),
                      borderRadius: BorderRadius.circular(45), // 둥글게 설정
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
                      borderRadius: BorderRadius.circular(45), // 둥글게 설정
                      child: Image.asset(
                        'assets/sos_button.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16), // 오른쪽 여백
              ],
            ),
            SizedBox(height: 16),

            //////////////////////// 알림목록 1 ////////////////////////
            Container(
              width: double.infinity,
              height: 73,
              margin: EdgeInsets.symmetric(horizontal: 16),
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
                onTap: () {},
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

            SizedBox(height: 16),

            //////////////////////// 알림목록 2 ////////////////////////
            Container(
              width: double.infinity,
              height: 73,
              margin: EdgeInsets.symmetric(horizontal: 16),
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
                onTap: () {},
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
          ],
        ),
      ),
    );
  }
}
