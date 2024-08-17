import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/disaster_message.dart'; // 모델 파일 경로를 올바르게 지정
import 'package:intl/intl.dart'; // 날짜 포맷팅 패키지

Future<List<DisasterMessage>> fetchDisasterMessagesFromApi(String regionName) async {
  final String serviceKey = '7X71315499M37R37'; // 서비스키

  // 현재 날짜와 2일 전 날짜 계산
  final now = DateTime.now();
  final twoDaysAgo = now.subtract(Duration(days: 2));

  // 날짜를 'YYYYMMDD' 형식으로 변환
  final DateFormat formatter = DateFormat('yyyyMMdd');
  final String endDate = formatter.format(now);
  final String crtDt = formatter.format(twoDaysAgo);

  // URL 쿼리 파라미터에 날짜 추가
  final String url = 'https://www.safetydata.go.kr/V2/api/DSSP-IF-00247?serviceKey=$serviceKey&crtDt=$crtDt&rgnNm=$regionName';

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);  // UTF-8로 디코딩
      final Map<String, dynamic> data = jsonDecode(responseBody);
      print('API Response Data: $data');  // 응답 데이터 로그

      // 'body'가 리스트 형태가 아니라면 적절히 수정
      final List<dynamic> items = data['body'] ?? [];
      print('Fetched items:');
      for (var item in items) {
        // 각 item이 JSON 객체인지 확인 후 변환
        final message = DisasterMessage.fromJson(item);
        print('Message: ${message.msgCn}');
        print('Region: ${message.rcptnRgnNm}');
        print('Date: ${message.crtDt}');
        print('Registration Date: ${message.regYmd}');
        print('Emergency Step: ${message.emrgStepNm}');
        print('SN: ${message.sn}');
        print('Destination: ${message.dstSeNm}');
        print('Modification Date: ${message.mdfcnYmd}');
      }

      return items.map((json) => DisasterMessage.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print('Error: $e');
    return [];
  }
}
