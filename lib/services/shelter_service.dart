import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:pro_max_ject/models/shelter_map.dart';
import 'package:location/location.dart';
import 'package:pro_max_ject/services/location_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ShelterService {
  final String _civilDefenseUrl = dotenv.env['CIVIL_DEFENSE_API_URL']!;
  final String _civilDefenseServiceKey = dotenv.env['CIVIL_DEFENSE_SERVICE_KEY']!;

  final String _disasterUrl = dotenv.env['DISASTER_API_URL']!;
  final String _disasterServiceKey = dotenv.env['DISASTER_SERVICE_KEY']!;

  final LocationService _locationService = LocationService();

  Future<List<Shelter>> fetchShelters() async {
    try {
      final LocationData? locationData = await _locationService.getCurrentLocation();
      if (locationData == null) {
        throw Exception('Failed to get current location');
      }

      final double currentLat = locationData.latitude!;
      final double currentLot = locationData.longitude!;

      final civilDefenseShelters = await _fetchCivilDefenseShelters(currentLat, currentLot);
      final disasterShelters = await _fetchDisasterShelters(currentLat, currentLot);

      final List<Shelter> allShelters = [...civilDefenseShelters, ...disasterShelters];
      final filteredShelters = allShelters.where((shelter) => shelter.distance != null && shelter.distance! <= 1000).toList();

      filteredShelters.sort((a, b) => a.distance!.compareTo(b.distance!));

      return filteredShelters;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<Shelter>> _fetchCivilDefenseShelters(double currentLat, double currentLot) async {
    final List<Shelter> shelters = [];
    int pageNo = 1;
    final int numOfRows = 1000;

    while (true) {
      final uri = Uri.parse(_civilDefenseUrl).replace(queryParameters: {
        'serviceKey': _civilDefenseServiceKey,
        'pageNo': pageNo.toString(),
        'numOfRows': numOfRows.toString(),
      });

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        if (data['header']['resultCode'] == '30') {
          throw Exception('Service key error');
        }

        final List<dynamic> items = data['body'] ?? [];
        if (items.isEmpty) {
          break;
        }

        final newShelters = items.map((item) {
          final shelter = Shelter.fromCivilDefense(item);
          shelter.distance = Geolocator.distanceBetween(
            currentLat,
            currentLot,
            shelter.latitude,
            shelter.longitude,
          );
          return shelter;
        }).toList();

        shelters.addAll(newShelters);
        pageNo++;
      } else {
        throw Exception('Failed to load civil defense shelters');
      }
    }

    return shelters;
  }

  Future<List<Shelter>> _fetchDisasterShelters(double currentLat, double currentLot) async {
    final uri = Uri.parse(_disasterUrl).replace(queryParameters: {
      'serviceKey': _disasterServiceKey,
      'pageNo': '1',
      'numOfRows': '1000',
      'startLat': (currentLat - 0.01).toString(),
      'endLat': (currentLat + 0.01).toString(),
      'startLot': (currentLot - 0.01).toString(),
      'endLot': (currentLot + 0.01).toString(),
    });

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      if (data['header']['resultCode'] == '30') {
        throw Exception('Service key error');
      }

      final List<dynamic> items = data['body'] ?? [];
      return items.map((item) {
        final shelter = Shelter.fromDisaster(item);
        shelter.distance = Geolocator.distanceBetween(
          currentLat,
          currentLot,
          shelter.latitude,
          shelter.longitude,
        );
        return shelter;
      }).toList();
    } else {
      throw Exception('Failed to load disaster shelters');
    }
  }
}
