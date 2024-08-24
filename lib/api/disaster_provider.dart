import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';  // SchedulerBinding을 사용하기 위한 import
import 'package:intl/intl.dart';
import 'package:pro_max_ject/models/disaster_message.dart';
import 'package:pro_max_ject/services/disaster_service.dart';
import 'package:pro_max_ject/services/location_service.dart';

class DisasterProvider with ChangeNotifier {
  final DisasterService _disasterService = DisasterService(); // 서비스 인스턴스
  List<DisasterMessage> _allDisasterMessages = []; // 전체 데이터 저장
  List<DisasterMessage> _disasterMessages = []; // 현재 페이지에 표시할 데이터
  bool _isLoading = false; // 로딩 상태를 추적하기 위한 변수
  bool _hasMore = true; // 더 많은 데이터가 있는지 여부
  int _currentPage = 1; // 현재 페이지
  final LocationService _locationService = LocationService(); // 위치 서비스 인스턴스
  final int _pageSize = 10; // 페이지당 개수

  List<DisasterMessage> get disasterMessages => _disasterMessages;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  // 필터링 관련 변수
  Map<String, bool> _filters = {
    '태풍': true,
    '건조': true,
    '산불': true,
    '산사태': true,
    '호우': true,
    '홍수': true,
    '폭염': true,
    '안개': true,
    '풍량': true,
    '미세먼지': true,
    '대조기': true,
    '가뭄': true,
    '대설': true,
    '지진해일': true,
    '지진': true,
    '황사': true,
    '한파': true,
    '강풍': true,
    '전염병':true,
    '기타': true,
  };

  Map<String, bool> get filters => _filters;

  set filters(Map<String, bool> newFilters) {
    _filters = newFilters;
    notifyListeners(); // 필터가 변경되면 UI를 업데이트
    _loadFilteredData(); // 필터 적용 후 데이터 로드
  }

  Future<void> _loadFilteredData() async {
    _disasterMessages = _getFilteredMessages();
    _hasMore = _disasterMessages.length > _pageSize;
    _notifyListenersSafely(); // 상태를 안전하게 업데이트
  }

  // 전체 데이터를 한 번에 로드하는 메서드
  Future<void> loadAllDisasterMessages() async {
    if (_isLoading) return; // 이미 로딩 중이면 중복 호출 방지

    _isLoading = true;
    _notifyListenersSafely(); // 상태를 안전하게 업데이트

    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(Duration(days: 30));

    final DateFormat formatter = DateFormat('yyyyMMdd');
    final String crtDt = formatter.format(thirtyDaysAgo);

    try {
      final locationData = await _locationService.getCurrentLocation();
      if (locationData != null) {
        final addressData = await _locationService.getAddressFromCoordinates(
          locationData.latitude!,
          locationData.longitude!,
        );

        if (addressData != null) {
          final regionName = addressData['region1']; // 지역명 추출

          if (regionName != null) {
            final List<DisasterMessage> messages = await _disasterService.fetchDisasterMessagesFromApi(
              regionName,
              pageNo: 1,
              pageSize: 1000, // 큰 페이지 크기로 전체 데이터 로드
            );

            _allDisasterMessages = messages;
            _allDisasterMessages.sort((a, b) => b.crtDt.compareTo(a.crtDt));

            await _loadFilteredData(); // 필터 적용 후 데이터 로드
          } else {
            print('Failed to get region name');
          }
        } else {
          print('Failed to get address data');
        }
      } else {
        print('Failed to get location');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      _isLoading = false;
      _notifyListenersSafely(); // 상태를 안전하게 업데이트
    }
  }

  // 페이지네이션을 처리하는 메서드
  List<DisasterMessage> _getPaginatedMessages() {
    final startIndex = (_currentPage - 1) * _pageSize;
    final endIndex = startIndex + _pageSize;
    return _disasterMessages.sublist(startIndex, endIndex.clamp(0, _disasterMessages.length));
  }

  // 페이지를 변경하고 데이터를 갱신하는 메서드
  Future<void> loadDisasterMessages({bool refresh = false}) async {
    if (_isLoading) return; // 이미 로딩 중이면 중복 호출 방지

    if (refresh) {
      _currentPage = 1; // 새로 고침 시 페이지 번호 초기화
      _disasterMessages.clear(); // 기존 데이터 클리어
      _hasMore = true; // 데이터가 더 있는지 여부 초기화
      await loadAllDisasterMessages(); // 전체 데이터 로드
    } else {
      if (_hasMore) {
        _disasterMessages.addAll(_getPaginatedMessages());
        _currentPage++;
        if (_disasterMessages.length >= _allDisasterMessages.length) {
          _hasMore = false;
        }
      } else {
        print('No more data to load');
      }
    }

    _notifyListenersSafely(); // 상태를 안전하게 업데이트
  }

  List<DisasterMessage> _getFilteredMessages() {
    // 활성화된 필터 목록을 작성합니다.
    final selectedTypes = _filters.keys
        .where((type) => _filters[type] == true)
        .toList();

    print('Selected types: $selectedTypes');

    _allDisasterMessages.forEach((message) {
      print('Message type: ${message.dstSeNm}');
    });

    // 필터링된 메시지를 반환하는 로직
    return _allDisasterMessages
        .where((message) {
      // 선택된 필터가 하나라도 활성화된 경우
      if (selectedTypes.isNotEmpty) {
        return selectedTypes.contains(message.dstSeNm);
      }

      // 선택된 필터가 없고 '기타' 필터가 활성화된 경우
      return _filters['기타'] == true;
    }).toList();
  }



  // 데이터를 비우고 상태를 리셋하는 메서드
  void clearDisasterMessages() {
    _allDisasterMessages.clear();
    _disasterMessages.clear();
    _notifyListenersSafely(); // 상태를 안전하게 업데이트
  }

  // 최신순으로 정렬
  void sortMessagesByDate() {
    _allDisasterMessages.sort((a, b) => b.crtDt.compareTo(a.crtDt));
    _disasterMessages = _getPaginatedMessages();
    _notifyListenersSafely(); // 상태를 안전하게 업데이트
  }

  // 상태를 안전하게 업데이트하는 메서드
  void _notifyListenersSafely() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
