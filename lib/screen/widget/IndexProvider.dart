import 'package:flutter/material.dart';

class IndexProvider with ChangeNotifier {
  int _selectedIndex = 1;

  int get selectedIndex => _selectedIndex;

  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
