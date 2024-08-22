import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:location/location.dart';
import 'package:pro_max_ject/screen/disaster_news.dart';
import 'package:pro_max_ject/screen/map.dart';
import 'package:pro_max_ject/screen/notice.dart';
import 'package:pro_max_ject/screen/reminder.dart';
import 'package:pro_max_ject/screen/sos.dart';
import 'package:pro_max_ject/screen/widget/IndexProvider.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    super.initState();
    _locateMe();
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
      body: SingleChildScrollView(
        child: Container(
          width: width,
          color: Color(0xFFF0F1F0),
          child: Column(
            children: [
              //////////////////////// 상단 바 ////////////////////////
              Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.02), // 상단 바 여백
                child: Row(
                  children: [
                    Text(
                      '이재난녕',
                      style: TextStyle(
                        color: Color(0xFF415C40),
                        fontSize: width * 0.06,
                        fontFamily: 'BM_HANNA_TTF',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        context.read<IndexProvider>().setIndex(2);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Reminder()),
                        );
                      },
                      child: const Icon(
                        Icons.notifications,
                        color: Color(0xEF537052),
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              //////////////////////// 1번째 공지부분 //////////////////////////
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Notice()),
                  );
                },
                child: Container(
                  width: width * 0.9,
                  height: height * 0.05,
                  margin: EdgeInsets.symmetric(horizontal: width * 0.04),
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
              SizedBox(height: height * 0.02),
              //////////////////////// 재해 방안(큰 2번째 목록) ////////////////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      context.read<IndexProvider>().setIndex(0);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MapPage()),
                      );
                    },
                    child: Container(
                      width: width * 0.4,
                      height: width * 0.4,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
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
                  //---------뉴스페이지-----------------------------------
                  InkWell(
                    onTap: () {
                      context.read<IndexProvider>().setIndex(1); // 1로 설정 (추가적인 설정에 따라 조정 가능)
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DisasterNewsPage()),
                      );
                    },
                    child: Container(
                      width: width * 0.4,
                      height: width * 0.4,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.00, -1.00),
                          end: Alignment(0, 1),
                          colors: [Color(0xFFFDD8C3), Color(0xFFFF8873)],
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              //////////////////////// 지도 위치와 SOS 위치 ////////////////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      context.read<IndexProvider>().setIndex(0);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MapPage()),
                      );
                    },
                    child: Container(
                      width: width * 0.4,
                      height: width * 0.4,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
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
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(45),
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
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SosWidget()),
                      );
                    },
                    child: Container(
                      width: width * 0.4,
                      height: width * 0.4,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.00, -1.00),
                          end: Alignment(0, 1),
                          colors: [Color(0xFFFDD8C3), Color(0xFFFF8873)],
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: Image.asset(
                          'assets/sos_button.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              //////////////////////// 알림목록 1 ////////////////////////
              Container(
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
                child: InkWell(
                  onTap: () {
                    context.read<IndexProvider>().setIndex(2);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Reminder()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '폭염주의보 지속 발효 중. 부모님께 안부전화드리기, 야외활동 자제, 폭염 안전 수칙(물, 그늘, 휴식) 준수 등 건강관리에 유의 바랍니다. [인천광역시]',
                      style: TextStyle(
                        color: Color(0xFF24252C),
                        fontSize: width * 0.03,
                        fontFamily: 'Lexend Deca',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              //////////////////////// 알림목록 2 ////////////////////////
              Container(
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
                child: InkWell(
                  onTap: () {
                    context.read<IndexProvider>().setIndex(2);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Reminder()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '폭염주의보 지속 발효 중. 부모님께 안부전화드리기, 야외활동 자제, 폭염 안전 수칙(물, 그늘, 휴식) 준수 등 건강관리에 유의 바랍니다. [인천광역시]',
                      style: TextStyle(
                        color: Color(0xFF24252C),
                        fontSize: width * 0.03,
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
      ),
    );
  }
}