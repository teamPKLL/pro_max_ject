import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:location/location.dart';

void main() {
  runApp(const MapPage());
}

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: const TestView(),
    );
  }
}

class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  double lat = 0;
  double lng = 0;
  Location location = Location();
  bool _serviceEnabled = true;
  late PermissionStatus _permissionGranted;
  Set<Marker> markers = {}; // 마커 변수
  late KakaoMapController mapController;
  late LatLng currentLatLng;

  @override
  void initState() {
    super.initState();
    _locateMe(); // 현재 위치를 가져와 지도에 마커를 찍고, 지도 중심을 이동
  }

  Future<void> _locateMe() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
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
      currentLatLng = LatLng(lat, lng);

      // 현재 위치에 마커 추가
      markers.add(
        Marker(
          markerId: UniqueKey().toString(),
          latLng: currentLatLng,
        ),
      );

      // 맵 컨트롤러가 있다면 지도 중심을 현재 위치로 이동
      if (mapController != null) {
        mapController.setCenter(currentLatLng);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F0), // 전체 배경 컬러
      appBar: AppBar(
        title: const Text(
          '이재난녕',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'BM_HANNA_TTF',
          ),
        ),
        backgroundColor: const Color(0xEF537052),
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // 알림 버튼 클릭 시 동작
            },
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: KakaoMap(
              onMapCreated: (controller) {
                mapController = controller;
                // 지도 생성 후 현재 위치 가져오기
                _locateMe();
              },
              markers: markers.toList(),
              center: LatLng(lat, lng), // 초기 위치는 현재 위치
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x30000000),
                    blurRadius: 4,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '폭염주의보 지속 발효 중. 부모님께 안부전화드리기, 야외활동 자제, 폭염 안전 수칙(물, 그늘, 휴식) 준수 등 건강관리에 유의 바랍니다. [인천광역시]',
                    style: TextStyle(
                      color: Color(0xFF24252C),
                      fontSize: 11,
                      fontFamily: 'Lexend Deca',
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '폭염주의보 지속 발효 중. 부모님께 안부전화드리기, 야외활동 자제, 폭염 안전 수칙(물, 그늘, 휴식) 준수 등 건강관리에 유의 바랍니다. [인천광역시]',
                    style: TextStyle(
                      color: Color(0xFF24252C),
                      fontSize: 11,
                      fontFamily: 'Lexend Deca',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
