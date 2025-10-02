import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/paciente_controller.dart';
import '../models/paciente.dart';

class RegistroPacienteView extends StatefulWidget {
  RegistroPacienteView({Key? key}) : super(key: key);

  @override
  State<RegistroPacienteView> createState() => _RegistroPacienteViewState();
}

class _RegistroPacienteViewState extends State<RegistroPacienteView> {
  final PacienteController controller = Get.find();
  late final TextEditingController nombreController;
  late final TextEditingController edadController;
  late final TextEditingController diagnosticoController;

  Paciente? paciente;

  @override
  void initState() {
    super.initState();
    paciente = Get.arguments;
    nombreController = TextEditingController(text: paciente?.nombre ?? '');
    edadController = TextEditingController(text: paciente?.edad.toString() ?? '');
    diagnosticoController = TextEditingController(text: paciente?.diagnostico ?? '');
  }

  @override
  void dispose() {
    nombreController.dispose();
    edadController.dispose();
    diagnosticoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(paciente == null ? 'Registrar datos del Paciente' : 'Actualizar datos del Paciente')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.local_hospital,
                      size: 60,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: nombreController,
                      decoration: const InputDecoration(
                        labelText: 'Nombre',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: edadController,
                      decoration: const InputDecoration(
                        labelText: 'Edad',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: diagnosticoController,
                      decoration: const InputDecoration(
                        labelText: 'Diagnóstico',
                        prefixIcon: Icon(Icons.medical_services),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: Icon(paciente == null ? Icons.save : Icons.update),
                        label: Text(paciente == null ? 'Registrar datos' : 'Actualizar datos'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(fontSize: 18),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () async {
                          final nombre = nombreController.text.trim();
                          final edad = int.tryParse(edadController.text.trim()) ?? 0;
                          final diagnostico = diagnosticoController.text.trim();
                          if (nombre.isEmpty || diagnostico.isEmpty || edad <= 0) {
                            //Get.snackbar('Error', 'Todos los campos son obligatorios y la edad debe ser mayor a 0');
                            Get.snackbar(
                              'Error',
                              'Todos los campos son obligatorios y la edad debe ser mayor a 0',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.redAccent,
                              colorText: Colors.white,
                            );
                            return;
                          }
                          if (paciente == null) {
                            await controller.agregarPaciente(nombre, edad, diagnostico);
                          } else {
                            await controller.editarPaciente(paciente!.id, nombre, edad, diagnostico);
                          }
                          Get.back();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
