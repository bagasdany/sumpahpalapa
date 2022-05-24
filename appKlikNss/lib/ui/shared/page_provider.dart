import 'package:flutter/material.dart';

class PageProvider with ChangeNotifier {
  //state, nilai awalya
  int _currentIndex = 0;

  //getter dan setternya

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
