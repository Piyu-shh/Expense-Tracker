import 'package:expense_tracker/theme/theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _theme = lightMode;

  ThemeData get themeData => _theme;

  set themeData(ThemeData themeData) {
    _theme = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    _theme = _theme == lightMode ? darkMode : lightMode;
    notifyListeners();
  }
}
