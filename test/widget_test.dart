import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:proyecto_final/main.dart';
import 'package:proyecto_final/controllers/lang_controller.dart';
import 'package:proyecto_final/controllers/theme_controller.dart';
import 'package:proyecto_final/controllers/paciente_controller.dart';
import 'package:proyecto_final/services/paciente_db.dart';
import 'package:proyecto_final/models/paciente.dart';

/// Fake implementation of the DB service to avoid opening a real sqlite DB
class FakePacienteDbService extends PacienteDbService {
  final List<Paciente> _store = [];

  @override
  Future<PacienteDbService> init() async => this;

  @override
  Future<List<Paciente>> getAll() async => List.unmodifiable(_store);

  @override
  Future<void> insert(Paciente p) async {
    _store.add(p);
  }

  @override
  Future<void> update(Paciente p) async {
    final idx = _store.indexWhere((e) => e.id == p.id);
    if (idx >= 0) _store[idx] = p;
  }

  @override
  Future<void> delete(String id) async {
    _store.removeWhere((e) => e.id == id);
  }

  @override
  Future<void> printAllPacientes() async {}

  @override
  Future<void> close() async {}
}

void main() {
  testWidgets('MainApp muestra pantalla inicial vacía', (WidgetTester tester) async {
    // Reset Get state and register minimal dependencies used by MainApp
    Get.reset();
    Get.put(LangController());
  // Register fake DB service under the base type so Get.find<PacienteDbService>() works
  Get.put<PacienteDbService>(FakePacienteDbService());
  Get.put(PacienteController());
  Get.put(ThemeController());

    // Build app
    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle();

    // Verificaciones básicas de la pantalla inicial
    expect(find.text('Registro Médico'), findsOneWidget);
    expect(find.text('No hay pacientes registrados'), findsOneWidget);
    expect(find.byIcon(Icons.person_add), findsWidgets);
  });

  testWidgets('Agregar paciente actualiza la UI', (WidgetTester tester) async {
    // Reset Get and register fresh instances
    Get.reset();
    final fakeDb = FakePacienteDbService();
    Get.put<LangController>(LangController());
    Get.put<PacienteDbService>(fakeDb);
    Get.put(PacienteController());
    Get.put(ThemeController());

    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle();

    // Initially no pacientes
    expect(find.text('No hay pacientes registrados'), findsOneWidget);

    // Add a paciente via controller
    final controller = Get.find<PacienteController>();
    await controller.agregarPaciente('Juan', 30, 'Dolor de cabeza');

    // Rebuild and wait
    await tester.pumpAndSettle();

    // Now the list should show the paciente
    expect(find.text('Juan'), findsOneWidget);
    expect(find.textContaining('Edad: 30'), findsOneWidget);
  });
}
