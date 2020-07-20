import 'package:flutter/cupertino.dart';

class BottomNavProvider with ChangeNotifier {
  int _index = 0;
  set setIndex(int value) {
    _index = value;
    notifyListeners();
  }

  int get index => _index;
}
