import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  final themeMode = ThemeMode.system.obs;

  void toggleTheme(bool isDark) {
    themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void setSystemTheme() {
    themeMode.value = ThemeMode.system;
  }
}
