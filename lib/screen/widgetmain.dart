import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:location/location.dart';
import 'package:pro_max_ject/screen/widget/NoticeDisplayWidget.dart';
import 'package:pro_max_ject/services/notice_service.dart';
import 'package:provider/provider.dart';

import '../api/disaster_provider.dart';
import 'common_sense.dart';
import 'disaster_news.dart';
import 'map.dart';
import 'notification/notice_user.dart';
import 'reminder.dart';
import 'sos.dart';
import 'widget/IndexProvider.dart';

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
  double lat = 0;
  double lng = 0;
  Location location = Location();
  Set<Marker> markers = {};
  late KakaoMapController mapController;
  final NoticeService _noticeService = NoticeService();
  List<String> noticeTitles = [];

  @override
  void initState() {
    super.initState();
    _locateMe();
    _fetchNoticeTitles();
  }

  Future<void> _fetchNoticeTitles() async {
    try {
      List<String> titles = await _noticeService.getRecentNoticeTitles(3); // Fetch the latest 3 titles
      setState(() {
        noticeTitles = titles;
      });
    } catch (e) {
      print('Failed to fetch notice titles: $e');
    }
  }

  Future<void> _locateMe() async {
    bool _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    PermissionStatus _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final locationData = await location.getLocation();
    setState(() {
      lat = locationData.latitude!;
      lng = locationData.longitude!;
      LatLng currentLatLng = LatLng(lat, lng);

      markers.add(
        Marker(
          markerId: UniqueKey().toString(),
          latLng: currentLatLng,
        ),
      );

      if (mapController != null) {
        mapController.setCenter(currentLatLng);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF0F1F0),
      appBar: AppBar(
        title: Text(
          '이재난녕',
          style: TextStyle(
            color: Color(0xEF537052),
            fontSize: width * 0.07,
            fontFamily: 'BM_HANNA_TTF',
          ),
        ),
        backgroundColor: Color(0xFFF0F1F0),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height * 0.02),
            NoticeDisplayWidget(
                strings: noticeTitles,
                // TODO : 리스트는 공지사항 DB에서 title 몇개만 가져오는걸로..?
                displayDuration: const Duration(seconds: 4),
                context: context,
                width: width,
                height: height
            ),
            SizedBox(height: height * 0.03),

            // 재해 방안(큰 2번째 목록)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGridItem2(
                  context: context,
                  imagePath: 'assets/sangsik.png',
                  width: width,
                  onTap: () {
                    context.read<IndexProvider>().setIndex(1);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CommonScreen()),
                    );
                  },
                ),
                _buildGridItem2(
                  context: context,
                  imagePath: 'assets/news.png',
                  width: width,
                  onTap: () {
                    context.read<IndexProvider>().setIndex(1);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DisasterNewsPage()),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: height * 0.03),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMapItem(context, width),
                _buildGridItem1(
                  context: context,
                  imagePath: 'assets/sos_button.png',
                  width: width,
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SosWidget()),
                          (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: height * 0.03),

            // 알림 목록 1
            _buildReminderItem(context, width, height, 0),
            SizedBox(height: height * 0.02),

            // 알림 목록 2
            _buildReminderItem(context, width, height, 1),
            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem1({
    required BuildContext context,
    required String imagePath,
    required double width,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width * 0.4, // 외부 컨테이너 크기 조절
        height: width * 0.4, // 외부 컨테이너 크기 조절
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFFFDD8C3), Color(0xFFFF8873)], // 그라데이션 색상
          ),
          borderRadius: BorderRadius.circular(45),
          boxShadow: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10.0), // Padding 값을 조정해 크기 조절
            child: Image.asset(
              imagePath,
              // fit: BoxFit.contain, // 이미지를 컨테이너에 맞추어 조절
              alignment: Alignment.center,
              width: width * 0.8, // 이미지의 너비를 직접 조정하여 크기 설정
              height: width * 0.8, // 이미지의 높이를 직접 조정하여 크기 설정
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem2({
    required BuildContext context,
    required String imagePath,
    required double width,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width * 0.4,
        height: width * 0.4,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFFFFF8D3), Color(0xFFDAEAE9), Color(0xFFB5DCFF)], // 그라데이션 색상 추가
          ),
          borderRadius: BorderRadius.circular(45),
          boxShadow: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMapItem(BuildContext context, double width) {
    return InkWell(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(45),
        child: Stack(
          children: [
            Container(
              width: width * 0.4,
              height: width * 0.4,
              child: KakaoMap(
                onMapCreated: (controller) {
                  mapController = controller;
                  _locateMe();
                },
                markers: markers.toList(),
                center: LatLng(lat, lng),
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(45),
                  onTap: () {
                    context.read<IndexProvider>().setIndex(0);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapPage()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderItem(
      BuildContext context, double width, double height, int index) {
    return Consumer<DisasterProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Container(
            width: width * 0.9,
            height: height * 0.1,
            margin: EdgeInsets.symmetric(horizontal: width * 0.04),
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
                ),
              ],
            ),
            child: Center(
              child: CircularProgressIndicator(), // 로딩 인디케이터
            ),
          );
        }

        if (provider.disasterMessages.isEmpty || index >= provider.disasterMessages.length) {
          return InkWell(
            onTap: () {
              context.read<IndexProvider>().setIndex(2);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Reminder()),
              );
            },
            child: Container(
              width: width * 0.9,
              height: height * 0.1,
              margin: EdgeInsets.symmetric(horizontal: width * 0.04),
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
                  ),
                ],
              ),
              child: Center(child: Text('No messages available')),
            ),
          );
        }

        final message = provider.disasterMessages[index];
        return InkWell(
          onTap: () {
            context.read<IndexProvider>().setIndex(2);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Reminder()),
            );
          },
          child: Container(
            width: width * 0.9,
            height: height * 0.1,
            margin: EdgeInsets.symmetric(horizontal: width * 0.04),
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
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 24),
                      child: Text(
                        '[${message.rcptnRgnNm}] ${message.msgCn}',
                        style: TextStyle(
                          color: Color(0xFF24252C),
                          fontSize: 11,
                          fontFamily: 'Lexend Deca',
                          fontWeight: FontWeight.w400,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    bottom: 8,
                    child: Text(
                      _formatDate(message.regYmd),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        fontFamily: 'Lexend Deca',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDate(String dateStr) {
    try {
      final cleanDateStr = dateStr.split('.').first;
      final DateTime date = DateTime.parse(cleanDateStr);
      final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
      return formatter.format(date);
    } catch (e) {
      return dateStr;
    }
  }
}