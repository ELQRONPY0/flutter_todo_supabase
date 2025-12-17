import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider لإدارة الوضع الداكن (Dark Mode)
/// يستخدم SharedPreferences لحفظ تفضيلات المستخدم
class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  /// تهيئة Provider - تحميل التفضيلات المحفوظة
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  /// تبديل الوضع الداكن
  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }
}
