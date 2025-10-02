import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_final/controllers/lang_controller.dart';
import 'package:proyecto_final/controllers/paciente_controller.dart';
import 'package:proyecto_final/controllers/theme_controller.dart';
import 'package:proyecto_final/services/paciente_db.dart';
import 'package:proyecto_final/utils/app_translation.dart';
import 'package:proyecto_final/utils/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(LangController());
  await Get.putAsync(() async => PacienteDbService().init());
  Get.put(PacienteController());
  Get.put(ThemeController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Get.find<LangController>();
    final themeController = Get.find<ThemeController>();
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: AppTranslation(),
        locale: lang.locale.value,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.light(
            primary: Colors.teal,
            secondary: Colors.orange,
            background: Colors.white,
            surface: Colors.white,
          ),
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.dark(
            primary: Colors.tealAccent,
            secondary: Colors.deepOrangeAccent,
            background: Color(0xFF121212),
            surface: Color(0xFF1E1E1E),
          ),
          scaffoldBackgroundColor: Color(0xFF121212),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.tealAccent,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        themeMode: themeController.themeMode.value,
        initialRoute: '/',
        getPages: AppRoutes.routes,
      ),
    );
  }
}