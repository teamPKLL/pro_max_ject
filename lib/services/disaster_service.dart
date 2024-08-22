import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/disaster_message.dart'; // 모델 파일 경로를 올바르게 지정
import 'package:intl/intl.dart'; // 날짜 포맷팅 패키지

class DisasterService {
  final String serviceKey = '7X71315499M37R37'; // 서비스키

  Future<List<DisasterMessage>> fetchDisasterMessagesFromApi(
      String regionName, {
        required int pageNo,
        required int pageSize,
      }) async {
    // 현재 날짜와 30일 전 날짜 계산
    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(Duration(days: 30));

    // 날짜를 'YYYYMMDD' 형식으로 변환
    final DateFormat formatter = DateFormat('yyyyMMdd');
    final String crtDt = formatter.format(thirtyDaysAgo);

    // URL 쿼리 파라미터에 날짜, 페이지 번호, 페이지 사이즈 추가
    final String url =
        'https://www.safetydata.go.kr/V2/api/DSSP-IF-00247?serviceKey=$serviceKey&numOfRows=$pageSize&pageNo=$pageNo&crtDt=$crtDt&rgnNm=$regionName';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final responseBody = utf8.decode(response.bodyBytes); // UTF-8로 디코딩
        final Map<String, dynamic> data = jsonDecode(responseBody);

        // 'body'가 리스트 형태가 아니라면 적절히 수정
        final List<dynamic> items = data['body'] ?? [];

        // json 객체를 DisasterMessage로 변환
        return items.map((json) => DisasterMessage.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
