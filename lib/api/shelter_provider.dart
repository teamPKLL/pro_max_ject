import 'package:flutter/foundation.dart';
import 'package:pro_max_ject/models/shelter_map.dart';
import 'package:pro_max_ject/services/shelter_service.dart'; // 수정된 ShelterService

class ShelterProvider with ChangeNotifier {
  final ShelterService _shelterService = ShelterService();
  List<Shelter> _shelters = []; // ShelterMap을 Shelter로 변경
  bool _isLoading = false;
  String _error = '';

  // 대피소 목록을 반환합니다.
  List<Shelter> get shelters => _shelters; // ShelterMap을 Shelter로 변경
  bool get isLoading => _isLoading;
  String get error => _error;

  // 대피소를 검색하고 상태를 업데이트합니다.
  Future<void> searchShelters({
    required int pageNo,
    required int numOfRows,
    String? startLat,
    String? endLat,
    String? startLot,
    String? endLot,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      // 대피소 검색
      _shelters = await _shelterService.fetchShelters();
      _error = '';

      // 데이터 로드 후 콘솔에 출력합니다.
      for (var shelter in _shelters) {
        print('Shelter Found:');
        print('Name: ${shelter.name}');
        print('Address: ${shelter.address}');
        print('Coordinates: (${shelter.latitude}, ${shelter.longitude})');
        print('Type: ${shelter.type}');
        print('---');
      }
    } catch (e) {
      _error = 'Failed to load shelters: $e';
      _shelters = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 대피소 목록을 업데이트합니다.
  void updateShelters(List<Shelter> shelters) { // ShelterMap을 Shelter로 변경
    _shelters = shelters;
    notifyListeners();
  }

  // 에러 메시지를 업데이트합니다.
  void setError(String error) {
    _error = error;
    _shelters = [];
    notifyListeners();
  }
}
