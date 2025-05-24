import 'package:flutter/material.dart';

class FontSizeModel extends ChangeNotifier {
  double _fontSize = 20.0;

  double get fontSize => _fontSize;

  void updateFontSize(double newSize) {
    _fontSize = newSize;
    notifyListeners(); // Notifies all listening widgets
  }
}
