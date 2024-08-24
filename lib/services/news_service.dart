import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pro_max_ject/models/disaster_news.dart';
import 'package:intl/intl.dart';

class DisasterNewsService {
  final String _newsUrl = 'https://www.safetydata.go.kr/V2/api/DSSP-IF-00051';
  final String _newsServiceKey = 'MWZ4TX61TQ3YY7MS'; // 서비스 키

  Future<List<DisasterNews>> fetchDisasterNews() async {
    try {
      // 현재 날짜와 한 달 전 날짜를 계산합니다.
      final DateTime now = DateTime.now();
      final DateTime oneMonthAgo = now.subtract(Duration(days: 7));

      // 날짜를 'YYYYMMDD' 형식으로 포맷합니다.
      final String startDate = DateFormat('yyyyMMdd').format(oneMonthAgo);
      final String endDate = DateFormat('yyyyMMdd').format(now);

      // 데이터를 저장할 리스트를 생성합니다.
      List<DisasterNews> allNews = [];

      // 한 달 전부터 현재까지의 모든 뉴스를 가져오기 위해 루프를 사용합니다.
      int pageNo = 1;
      bool hasMoreData = true;

      while (hasMoreData) {
        // API 호출을 위한 URI를 생성합니다.
        final uri = Uri.parse(_newsUrl).replace(queryParameters: {
          'serviceKey': _newsServiceKey,
          'inqDt': startDate,   // 조회 시작일자 (YYYYMMDD)
          'pageNo': pageNo.toString(),
          'numOfRows': '100',   // 한 번에 최대 100개의 데이터를 가져옵니다.
        });

        // HTTP GET 요청을 보냅니다.
        final response = await http.get(uri);

        if (response.statusCode == 200) {
          // 응답이 성공적인 경우 데이터를 디코딩합니다.
          final data = jsonDecode(utf8.decode(response.bodyBytes));

          // body를 확인하여 데이터가 리스트인지 확인합니다.
          final body = data['body'];
          if (body is List) {
            final List<dynamic> items = List<dynamic>.from(body);

            // 데이터를 DisasterNews 객체 리스트로 변환합니다.
            final newsList = items.map((item) {
              if (item is Map<String, dynamic>) {
                return DisasterNews.fromJson(item);
              } else {
                throw Exception('Invalid item format');
              }
            }).toList();

            // 가져온 데이터를 모두 저장합니다.
            allNews.addAll(newsList);

            // 가져온 데이터가 100개 미만인 경우, 더 이상 데이터가 없다고 판단합니다.
            if (newsList.length < 100) {
              hasMoreData = false;
            } else {
              // 다음 페이지를 가져오기 위해 페이지 번호를 증가시킵니다.
              pageNo++;
            }
          } else {
            throw Exception('Invalid body structure');
          }
        } else {
          throw Exception('Failed to load disaster news');
        }
      }

      // 모든 데이터를 가져온 후, 전체 리스트를 반환합니다.
      return allNews;
    } catch (e) {
      // 에러 발생 시 콘솔에 출력하고 빈 리스트를 반환합니다.
      print('Error: $e');
      return [];
    }
  }
}
