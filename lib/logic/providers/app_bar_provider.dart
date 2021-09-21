import 'package:flutter/material.dart';

class AppIndex with ChangeNotifier {
  int _selectedIndex = 1;

  set changeIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  get currentIndex => _selectedIndex;
}
