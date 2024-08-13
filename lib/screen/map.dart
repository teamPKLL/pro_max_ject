import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  // 현재 위치 찍기
  double lat = 0;
  double lng = 0;
  Location location = Location();
  bool _serviceEnabled = true;
  PermissionStatus? _permissionGranted;
  late GoogleMapController mapController;
  late LatLng _center;
  late Set<Marker> _markers;

  @override
  void initState() {
    super.initState();
    _center = const LatLng(37.445884, 126.651960); // Default location
    _markers = {};
    _locateMe(); // Get the current location when the widget is initialized
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

    final LocationData locationData = await location.getLocation();
    setState(() {
      lat = locationData.latitude ?? 0.0;
      lng = locationData.longitude ?? 0.0;
      _center = LatLng(lat, lng);
      _markers = {
        Marker(
          markerId: const MarkerId('current_location'),
          position: _center,
        ),
      };


      if (mapController != null) {
        mapController.animateCamera(
          CameraUpdate.newLatLng(_center),
        );
      }
      // 현재위치 끝
    });
  }

  // 구글 맵 끌어오기
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _locateMe(); // 현재 주소 받아오기
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
              // Handle notification action
            },
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            // 구글맵
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              // 카메라 포지션(처음 잡는 곳
              initialCameraPosition: CameraPosition(
                // 현재 좌표로 고정한 _center로 11 화면 고정.
                target: _center,
                zoom: 11.0,
              ),
              // 마커도 현재 화면
              markers: _markers,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x30000000),
                    blurRadius: 4,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '폭염주의보 지속 발효 중. 부모님께 안부전화드리기, 야외활동 자제, 폭염 안전 수칙(물, 그늘, 휴식) 준수 등 건강관리에 유의 바랍니다. [인천광역시]',
                    style: TextStyle(
                      color: const Color(0xFF24252C),
                      fontSize: 11,
                      fontFamily: 'Lexend Deca',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '폭염주의보 지속 발효 중. 부모님께 안부전화드리기, 야외활동 자제, 폭염 안전 수칙(물, 그늘, 휴식) 준수 등 건강관리에 유의 바랍니다. [인천광역시]',
                    style: TextStyle(
                      color: const Color(0xFF24252C),
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
