import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/paciente_controller.dart';
import '../models/paciente.dart';
import '../services/paciente_db.dart';
import '../controllers/theme_controller.dart';

class PacientesView extends StatelessWidget {
  final PacienteController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro Médico'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt),
            tooltip: 'Imprimir pacientes en consola',
            onPressed: () async {
              await Get.find<PacienteDbService>().printAllPacientes();
              Get.snackbar('Consola', 'Pacientes impresos en consola');
            },
          ),
          Obx(() {
            final isDark = themeController.themeMode.value == ThemeMode.dark;
            return Switch(
              value: isDark,
              onChanged: (val) {
                themeController.toggleTheme(val);
              },
              activeColor: Colors.teal,
              inactiveThumbColor: Colors.orange,
              inactiveTrackColor: Colors.orange.shade200,
            );
          }),
        ],
      ),
      body: Obx(() {
        if (controller.pacientes.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.people_outline, size: 80, color: Colors.grey),
                const SizedBox(height: 16),
                const Text(
                  'No hay pacientes registrados',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  icon: const Icon(Icons.person_add),
                  label: const Text('Agregar paciente'),
                  onPressed: () => Get.toNamed('/registro'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: controller.pacientes.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final Paciente paciente = controller.pacientes[index];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(paciente.nombre.isNotEmpty ? paciente.nombre[0].toUpperCase() : '?'),
                ),
                title: Text(paciente.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Edad: ${paciente.edad}\nDiagnóstico: ${paciente.diagnostico}'),
                isThreeLine: true,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      tooltip: 'Editar',
                      onPressed: () {
                        Get.toNamed('/registro', arguments: paciente);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      tooltip: 'Eliminar paciente',
                      onPressed: () async {
                        await controller.eliminarPaciente(paciente.id);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: Obx(() => controller.pacientes.isEmpty
          ? const SizedBox.shrink()
          : FloatingActionButton.extended(
              onPressed: () => Get.toNamed('/registro'),
              icon: const Icon(Icons.person_add),
              label: const Text('Agregar paciente'),
              tooltip: 'Agregar paciente',
            )),
    );
  }
}
