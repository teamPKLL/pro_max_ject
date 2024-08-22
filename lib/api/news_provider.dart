import 'package:flutter/material.dart';
import 'package:pro_max_ject/models/disaster_news.dart';
import 'package:pro_max_ject/services/news_service.dart';

class DisasterNewsProvider with ChangeNotifier {
  final DisasterNewsService _newsService = DisasterNewsService();
  List<DisasterNews> _newsList = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<DisasterNews> get newsList => _newsList;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // 모든 뉴스를 최신순으로 재배치하여 가져오는 메소드
  Future<void> fetchNews() async {
    _isLoading = true;
    notifyListeners();
    try {
      // 서비스를 통해 모든 뉴스를 가져옵니다.
      final news = await _newsService.fetchDisasterNews();

      // 가져온 뉴스를 최신순으로 정렬합니다.
      _newsList = news;
      _newsList.sort((a, b) => b.crtDate.compareTo(a.crtDate));

      _errorMessage = ''; // 오류 메시지를 초기화합니다.
    } catch (e) {
      _errorMessage = 'Failed to load news: $e';
      _newsList = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
