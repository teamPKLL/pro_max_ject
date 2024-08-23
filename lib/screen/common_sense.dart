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
      home: const CommonScreen(),
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
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 2, // 열의 개수
                crossAxisSpacing: 10, // 아이템 사이의 가로 간격
                mainAxisSpacing: 10, // 아이템 사이의 세로 간격
                childAspectRatio: 1.4, // 박스 비율
                children: const [
                  CommonItem(
                    title: '폭염',
                    imageUrls: [
                      'assets/heatwave/heatwave1.png',
                      'assets/heatwave/heatwave2.png',
                      'assets/heatwave/heatwave3.png',
                    ],
                  ),
                  CommonItem(
                    title: '대설',
                    imageUrls: [
                      'assets/heavysnow/heavysnow1.jpg',
                      'assets/heavysnow/heavysnow2.jpg',
                      'assets/heavysnow/heavysnow3.jpg',
                    ],
                  ),
                  CommonItem(
                    title: '태풍, 호우',
                    imageUrls: [
                      'assets/typhoon/typhoon1.jpg',
                      'assets/typhoon/typhoon2.jpg',
                      'assets/typhoon/typhoon3.jpg',
                    ],
                  ),
                  CommonItem(
                    title: '황사',
                    imageUrls: [
                      'assets/yellowdust/yelliwdust1.png',
                      'assets/yellowdust/yellowdust2.png',
                    ],
                  ),
                  CommonItem(
                    title: '홍수',
                    imageUrls: [
                      'assets/flooding/flooding1.png',
                      'assets/flooding/flooding2.png',
                      'assets/flooding/flooding3.png',
                    ],
                  ),
                  CommonItem(
                    title: '한파',
                    imageUrls: [
                      'assets/coldwave/coldwave1.jpg',
                      'assets/coldwave/coldwave2.jpg',
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CommonItem extends StatefulWidget {
  final String title;
  final List<String> imageUrls;

  const CommonItem({super.key, required this.title, required this.imageUrls});

  @override
  _CommonItemState createState() => _CommonItemState();
}

class _CommonItemState extends State<CommonItem> {
  int _currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(widget.title),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 200,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: widget.imageUrls.length,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Image.asset(widget.imageUrls[index]);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.imageUrls.length,
                          (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: _currentPage == index ? 12.0 : 8.0,
                        height: _currentPage == index ? 12.0 : 8.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    ' ',
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
              widget.title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontFamily: 'BM_HANNA_TTF',
              ),
            ),
            const Align(
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
