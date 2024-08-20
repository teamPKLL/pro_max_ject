class Shelter {
  final String name;
  final double latitude;
  final double longitude;
  final String address;
  final String type;
  final String code;
  double? distance; // 거리를 저장할 필드 추가

  Shelter({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.type,
    required this.code,
    this.distance, // 생성자에 거리 필드 추가
  });

  factory Shelter.fromJson(Map<String, dynamic> json) {
    final code = json['SHLT_SE_CD'] as String;
    return Shelter(
      name: json['REARE_NM'] as String,
      latitude: (json['LAT'] as num).toDouble(),
      longitude: (json['LOT'] as num).toDouble(),
      address: json['RONA_DADDR'] as String,
      code: code,
      type: _getShelterType(code), // 코드에 따른 대피소 유형 설정
    );
  }

  // 대피소 구분 코드에 따른 유형 문자열 반환
  static String _getShelterType(String code) {
    switch (code) {
      case '1':
        return '한파 쉼터';
      case '2':
        return '무더위 쉼터';
      case '3':
        return '지진 옥외 대피장소';
      case '4':
        return '지진 해일 긴급 대피장소';
      default:
        return '정보 없음';
    }
  }
}
