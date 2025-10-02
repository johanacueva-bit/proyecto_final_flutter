import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LangController extends GetxController {
  final locale = const Locale("es", "EC").obs;

  void setLocale(Locale l) {
    locale.value = l;
    Get.updateLocale(l);
  }

  void showLanguage() {
    Get.bottomSheet(
      SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.language),
              title: Text("Español"),
              onTap: () {
                setLocale(const Locale("es", "EC"));
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text("Ingles"),
              onTap: () {
                setLocale(const Locale("en", "US"));
                Get.back();
              },
            ),
          ],
        ),
      ),
      backgroundColor: Get.theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    );
  }
}
