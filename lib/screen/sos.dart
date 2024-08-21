import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:location/location.dart';
import 'package:pro_max_ject/services/location_service.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(SosWidget());
}

_sendingMails() async {
  var url = Uri.parse("tel:01056766769");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

// SMS 보내기 함수
_sendingSMS(double lat, double lng, String address) async {
  var url = Uri.parse(
      "sms:01056766769?body=긴급 상황입니다. \n\n제 현재 위치는 \n위도: $lat, \n경도: $lng 입니다. \n주소: $address");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

class SosWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SosPage(),
    );
  }
}

class SosPage extends StatefulWidget {
  const SosPage({super.key});

  @override
  _SosPageState createState() => _SosPageState();
}

class _SosPageState extends State<SosPage> {
  double lat = 0;
  double lng = 0;
  String _address = '';
  Location location = Location();
  LocationService _locationService = LocationService();
  Set<Marker> markers = {};
  late KakaoMapController mapController;
  int _selectedIndex = 0; // 현재 선택된 인덱스

  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // 선택된 인덱스 업데이트
    });
  }

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

      _getAddress(lat, lng);  // 도로명 주소 가져오기
    });
  }

  Future<void> _getAddress(double lat, double lng) async {
    final addressData = await _locationService.getAddressFromCoordinates(lat, lng);
    if (addressData != null) {
      setState(() {
        _address = '${addressData['region1']} ${addressData['region2']} ${addressData['region3']}, ${addressData['address']}';
      });
    } else {
      setState(() {
        _address = '주소를 찾을 수 없습니다.';
      });
    }
  }

  void _onMedicalInfoTapped() {
    // 여기에 버튼 클릭 시 실행될 동작을 정의합니다.
    print('Medical info button tapped');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'SOS',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'BM_HANNA_TTF',
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFF5A4C), // FF5A4C
                Color(0xFFFFA55F), // FFA55F
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
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
              Container(
                width: double.infinity,
                height: 99,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: 5.0,
                      spreadRadius: 0.0,
                      offset: const Offset(0, -4), // 그림자
                    )
                  ],
                ),
              ),
            ],
          ),

          //////////////    sos 버튼   /////////////////
          Positioned(
            bottom: 45, // 하얀 박스 위에 조금 겹치도록 조정
            left: MediaQuery.of(context).size.width / 2 - 65.5, // 버튼을 중앙에 배치
            child: Group78(lat: lat, lng: lng, address: _address), // lat, lng, address 전달
          ),

          // 흰색 작은 박스 (의료정보 버튼)
          Positioned(
            bottom: 10, // sos 버튼 밑으로 조정
            left: MediaQuery.of(context).size.width / 2 - 57, // 중앙 정렬
            child: GestureDetector(
              onTap: _onMedicalInfoTapped,
              child: Container(
                width: 114,
                height: 31,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.50),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 2,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    '* 의료정보',
                    style: TextStyle(
                      color: Color(0xFFD32E24),
                      fontSize: 15,
                      fontFamily: "BM_HANNA_TTF",
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Group78 extends StatelessWidget {
  final double lat;
  final double lng;
  final String address;

  Group78({required this.lat, required this.lng, required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 131,
      height: 130,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 131,
              height: 130,
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: OvalBorder(),
                  shadows: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: 5.0,
                      offset: Offset(0, -4),
                    )
                  ]),
            ),
          ),
          Positioned(
            left: 11,
            top: 10,
            child: Container(
              width: 109,
              height: 109,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 109,
                      height: 109,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF5F5FA),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 8,
                    top: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3), // 그림자 색상 및 투명도
                            blurRadius: 6.0, // 흐림 효과 반경 (크기 줄임)
                            offset: Offset(0, 3), // 그림자의 오프셋 (살짝 줄임)
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            Colors.orangeAccent, // 그라데이션 시작 색상
                            Colors.redAccent, // 그라데이션 끝 색상
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: ClipOval( // 원형의 형태로 잘라주는 역할
                        child: Container(
                          width: 90.75, // 아이콘 크기
                          height: 90.75, // 아이콘 크기
                          child: PopupMenuButton<int>(
                            icon: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.orangeAccent, // 그라데이션 시작 색상
                                    Colors.redAccent, // 그라데이션 끝 색상
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Icon(
                                Icons.circle,
                                color: Colors.transparent, // 내부 아이콘의 색상을 투명하게 설정
                                size: 90.75, // 아이콘 크기
                              ),
                            ),
                            onSelected: (value) {
                              // 팝업 메뉴에서 선택된 항목에 따라 동작을 정의
                              if (value == 1) {
                                _sendingMails(); // 전화 걸기
                              } else if (value == 2) {
                                _sendingSMS(lat, lng, address); // SMS 보내기
                              } else {
                                print("Option null selected");
                              }
                            },
                            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                              PopupMenuItem<int>(
                                value: 1,
                                child: Text('119 긴급전화'),
                              ),
                              PopupMenuItem<int>(
                                value: 2,
                                child: Text('119 긴급 메시지'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
