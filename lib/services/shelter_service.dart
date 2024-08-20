import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pro_max_ject/models/shelter_map.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pro_max_ject/services/location_service.dart';

class ShelterService {
  final String _baseUrl = 'https://www.safetydata.go.kr/V2/api/DSSP-IF-10941';
  final String _serviceKey = '04YN24A74RIOZ5L2';

  final LocationService _locationService = LocationService();

  Future<List<Shelter>> fetchShelters() async {
    try {
      final LocationData? locationData = await _locationService.getCurrentLocation();
      if (locationData == null) {
        throw Exception('Failed to get current location');
      }

      final double currentLat = locationData.latitude!;
      final double currentLot = locationData.longitude!;

      final uri = Uri.parse(_baseUrl).replace(queryParameters: {
        'serviceKey': _serviceKey,
        'pageNo': '1',
        'numOfRows': '1000',
        'startLat': (currentLat - 0.01).toString(),
        'endLat': (currentLat + 0.01).toString(),
        'startLot': (currentLot - 0.01).toString(),
        'endLot': (currentLot + 0.01).toString(),
      });

      print('Request URI: $uri');

      final response = await http.get(uri);

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = utf8.decode(response.bodyBytes);
        final data = jsonDecode(responseBody);

        print('Decoded JSON data: $data');

        if (data['header']['resultCode'] == '30') {
          throw Exception('Service key error: ${data['header']['errorMsg']}');
        }

        final List<dynamic> items = data['body'] ?? [];
        final shelters = items.map((item) {
          final shelter = Shelter.fromJson(item);
          // 대피소와 현재 위치 사이의 거리 계산
          final distance = Geolocator.distanceBetween(
            currentLat,
            currentLot,
            shelter.latitude,
            shelter.longitude,
          );
          shelter.distance = distance; // 거리 저장
          return shelter;
        }).toList();

        // 거리 필터링
        final filteredShelters = shelters.where((shelter) => shelter.distance! <= 1000).toList();

        return filteredShelters;
      } else {
        throw Exception('Failed to load shelters: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
