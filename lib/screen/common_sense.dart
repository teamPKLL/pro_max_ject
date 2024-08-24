import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(const CommonSense());
}

class CommonSense extends StatelessWidget {
  const CommonSense({Key? key}) : super(key: key);

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
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          '재난 상식',
          style: TextStyle(
            color: Colors.white,
            fontSize: width * 0.06,
            fontFamily: 'BM_HANNA_TTF',
          ),
        ),
        centerTitle : true,
        backgroundColor: Color(0xEF537052),
        elevation: 4,
      ),
      backgroundColor: const Color(0xFFF0F1F0),
      body: Column(
        children: [
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
              content: SizedBox(
                height: 250,
                child: Column(
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
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: widget.imageUrls.length,
                      effect: WormEffect(
                        activeDotColor: Colors.blue,
                        dotColor: Colors.grey,
                        dotHeight: 8,
                        dotWidth: 8,
                        spacing: 8,
                      ),
                    ),
                  ],
                ),
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
        width: 100,
        height: 100,
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
            ),
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
