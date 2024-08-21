
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pro_max_ject/models/disaster_news.dart';

class DisasterNewsService {
  final String _newsUrl = 'https://www.safetydata.go.kr/V2/api/DSSP-IF-10747';
  final String _newsServiceKey = 'SY3F6264544PT140'; // 여기에 서비스 키를 입력하세요.

  Future<List<DisasterNews>> fetchDisasterNews() async {
    try {
      final uri = Uri.parse(_newsUrl).replace(queryParameters: {
        'serviceKey': _newsServiceKey,
        'pageNo': '1',
        'numOfRows': '10', // 페이지당 개수 설정 (예: 10)
      });

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));

        // Debug print to check the structure
        print('Parsed Data: ${data}');

        if (data['header']['resultCode'] == '30') {
          throw Exception('Service key error');
        }

        // Check if body is a list
        final body = data['body'];
        if (body is List) {
          // 'body' is a list, not a map
          final List<dynamic> items = List<dynamic>.from(body);

          // Print count of items to verify
          print('Number of items fetched: ${items.length}');

          final newsList = items.map((item) {
            // Ensure each item is a map
            if (item is Map<String, dynamic>) {
              return DisasterNews.fromJson(item);
            } else {
              throw Exception('Invalid item format');
            }
          }).toList();

          // Print a success message with the count of news items
          print('Successfully fetched and parsed ${newsList.length} news items.');

          return newsList;
        } else {
          throw Exception('Invalid body structure');
        }
      } else {
        throw Exception('Failed to load disaster news');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
