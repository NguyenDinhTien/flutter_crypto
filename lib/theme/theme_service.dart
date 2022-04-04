import 'package:crypto_flutter/shared/constants/constants.dart';
import 'package:crypto_flutter/shared/constants/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  final prefs = Get.find<SharedPreferences>();
  final key = SharePreferencesConstants.themeCurrent;

  ThemeMode getThemeMode() {
    
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  bool get isDarkMode => prefs.getBool(key) ?? false;

  void saveThemeMode(bool isDarkMode) {
    prefs.setBool(key, isDarkMode);
  }

  void changeThemeMode() {
    Get.changeThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
    saveThemeMode(!isDarkMode);
  }
}
