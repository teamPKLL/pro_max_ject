import 'package:flutter/material.dart';

void main() {
  runApp(CommonSense());
}

class CommonSense extends StatelessWidget {
  const CommonSense({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: CommonScreen(),
    );
  }
}

class CommonScreen extends StatelessWidget {
  const CommonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F0),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '재난 상식',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'BM_HANNA_TTF',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 2, // 열의 개수
                crossAxisSpacing: 10, // 아이템 사이의 가로 간격
                mainAxisSpacing: 10, // 아이템 사이의 세로 간격
                childAspectRatio: 1.4, // 박스 비율
                children: const [
                  CommonItem(title: '폭염', imageUrl: 'assets/heatwave.png'),
                  CommonItem(title: '침수', imageUrl: 'assets/flooding.png'),
                  CommonItem(title: '태풍, 호우', imageUrl: 'assets/typhoon.png'),
                  CommonItem(title: '지진', imageUrl: 'assets/earthquake.png'),
                  CommonItem(title: '홍수', imageUrl: 'assets/flood.png'),
                  CommonItem(title: '대설', imageUrl: 'assets/snow.png'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class CommonItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  const CommonItem({super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(imageUrl), // 이미지 표시
                  const SizedBox(height: 10),
                  Text(
                    '여기에 관련 정보를 추가할 수 있습니다.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'BM_HANNA_TTF',
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 다이얼로그 닫기
                  },
                  child: const Text('닫기'),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        width: 100, // 박스의 너비
        height: 100, // 박스의 높이
        padding: const EdgeInsets.all(12.0),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x30000000),
              blurRadius: 4,
              offset: Offset(0, 5),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontFamily: 'BM_HANNA_TTF'
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}