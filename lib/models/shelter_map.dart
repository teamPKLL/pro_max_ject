class Shelter {
  final String name;        // 대피소명
  final double latitude;    // 위도
  final double longitude;   // 경도
  final String address;     // 도로명주소 또는 상세주소
  final String type;        // 대피소 유형
  final String code;        // 대피소 구분 코드
  double? distance;         // 거리 필드 추가

  Shelter({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.type,
    required this.code,
    this.distance,
  });

  factory Shelter.fromCivilDefense(Map<String, dynamic> json) {
    String type = json['FCLT_SE'] as String? ?? 'Unknown';
    if (type == '0' || type.toLowerCase() == 'unknown') {
      type = '민방위 대피소';
    }

    return Shelter(
      name: json['SHLT_NM'] as String? ?? 'Unknown',
      latitude: (json['LAT'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['LOT'] as num?)?.toDouble() ?? 0.0,
      address: json['ROAD_NM_ADDR'] as String? ?? json['DADDR'] as String? ?? 'Unknown',
      type: type,
      code: json['FCLT_SE'] as String? ?? 'Unknown',
    );
  }

  factory Shelter.fromDisaster(Map<String, dynamic> json) {
    return Shelter(
      name: json['REARE_NM'] as String? ?? 'Unknown',
      latitude: (json['LAT'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['LOT'] as num?)?.toDouble() ?? 0.0,
      address: json['RONA_DADDR'] as String? ?? 'Unknown',
      type: json['SHLT_SE_NM'] as String? ?? 'Unknown',
      code: json['SHLT_SE_CD'] as String? ?? 'Unknown',
    );
  }
}
