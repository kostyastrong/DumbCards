import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Opaciter with ChangeNotifier {
  double _opacity = 0;

  double get opacity => _opacity;

  void setOpacity(double num) {
    _opacity = num;
    notifyListeners();
  }
}