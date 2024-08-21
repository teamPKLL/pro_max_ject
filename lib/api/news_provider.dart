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

  Future<void> fetchNews() async {
    _isLoading = true;
    notifyListeners();
    try {
      final news = await _newsService.fetchDisasterNews();
      _newsList = news;
      _errorMessage = ''; // Clear any previous error message
    } catch (e) {
      _errorMessage = 'Failed to load news: $e';
      _newsList = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
