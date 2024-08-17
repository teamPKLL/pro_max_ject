// class Shelter_map {
//  late String ctprvn_nm; // 시도명
//  late String sgg_nm; // 시군구명
//  late String vt_acmdfclty_nm; // 시설명
//  late String rdnmadr_cd; // 도로명 주소 코드.
//  late String xcord;  // 경도
//  late String ycord; // 위도
//  late String acmdfclty_se_nm; // 지진옥외대피장소 유형 구분
//  late String rn_adres; // 도로명 주소
//
//  // 생성자
//  Shelter_map( {
//    required this.ctprvn_nm,
//    required this.sgg_nm,
//    required this.vt_acmdfclty_nm,
//    required this.rdnmadr_cd,
//    required this.xcord,
//    required this.ycord,
//    required this.acmdfclty_se_nm,
//    required this.rn_adres,
//   });
//
//  /// User 객체를 JSON으로 변환
//  Map<String, dynamic> toJson() {
//    return {
//      'ctprvn_nm': ctprvn_nm,
//      'sgg_nm': sgg_nm,
//      'vt_acmdfclty_nm': vt_acmdfclty_nm,
//      'rdnmadr_cd' : rdnmadr_cd,
//      'xcord' : xcord,
//      'ycord' : ycord,
//      'acmdfclty_se_nm' : acmdfclty_se_nm,
//      'rn_adres' : rn_adres,
//    };
//  }
//
//  /// JSON을 User 객체로 변환
//  factory Shelter_map.fromJson(Map<String, dynamic> json) {
//    return Shelter_map(
//      ctprvn_nm: json['ctprvn_nm'] as String,
//      sgg_nm: json['sgg_nm'] as String,
//      vt_acmdfclty_nm: json['vt_acmdfclty_nm'] as String,
//        rdnmadr_cd: json['rdnmadr_cd'] as String,
//
//    );
//  }
//
// }