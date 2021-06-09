import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/modals/config.dart';

class MyTheme with ChangeNotifier {
  MyTheme() {
    if (box.containsKey('currentTheme'))
      isDark = box.get('currentTheme');
    else
      box.put('currentTheme', isDark);
  }
  var isDark = false;
  ThemeMode currentTheme() {
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme() {
    isDark = !isDark;
    box.put('currentTheme', isDark);
    notifyListeners();
  }
}
