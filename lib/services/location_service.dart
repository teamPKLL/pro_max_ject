import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:location/location.dart'; // 위치 관련 패키지

class LocationService {
  final String _kakaoApiKey = 'b3ad05ebb978ee3d4bc9ee6a18518b2e'; // 카카오 API 키

  // 현재 위치를 가져오는 메소드
  Future<LocationData?> getCurrentLocation() async {
    final location = Location();

    try {
      // 위치 권한 요청
      bool _serviceEnabled;
      PermissionStatus _permissionGranted;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return null;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return null;
        }
      }

      // 현재 위치 가져오기
      final LocationData _locationData = await location.getLocation();
      return _locationData;
    } catch (e) {
      print('Error getting location: $e');
      return null;
    }
  }

  Future<Map<String, String>?> getAddressFromCoordinates(double lat, double lng) async {
    final String url = 'https://dapi.kakao.com/v2/local/geo/coord2address.json?x=$lng&y=$lat&input_coord=WGS84';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'KakaoAK $_kakaoApiKey',
      });

      if (response.statusCode == 200) {
        print('Response status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        final responseBody = utf8.decode(response.bodyBytes);  // UTF-8로 디코딩
        final Map<String, dynamic> data = jsonDecode(responseBody);
        print('Kakao Geocoding API Response Data: $data');  // 응답 데이터 로그

        if (data['meta']['total_count'] > 0) {
          final address = data['documents'][0]['road_address'] ?? data['documents'][0]['address'];
          final region1 = address['region_1depth_name'];
          final region2 = address['region_2depth_name'];
          final region3 = address['region_3depth_name'];

          return {
            'region1': region1,
            'region2': region2,
            'region3': region3,
            'address': address['address_name'],
          };
        } else {
          print('No address found for the given coordinates');
        }
      } else {
        throw Exception('Failed to load address data');
      }
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }
}
