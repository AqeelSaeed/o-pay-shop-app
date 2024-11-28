import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/utils/shared_pref.dart';

class ThemeProvider with ChangeNotifier {
  var _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadTheme(); // Load the theme when the provider is initialized
  }

  void setTheme(themeMode) {
    _themeMode = themeMode;
    SharedPref.saveBool(
        key: 'isDark', value: themeMode == ThemeMode.dark); // Save preference
    notifyListeners();
  }

  // Load saved theme preference from SharedPreferences
  void _loadTheme() async {
    bool? isDark = SharedPref.getBool(key: 'isDark'); // Retrieve saved value
    _themeMode = (isDark) ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Notify listeners to rebuild UI with the correct theme
  }
}
