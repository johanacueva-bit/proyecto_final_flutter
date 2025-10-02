import 'package:get/get.dart';
import '../models/paciente.dart';
import 'package:uuid/uuid.dart';
import '../services/paciente_db.dart';

class PacienteController extends GetxController {
  var pacientes = <Paciente>[].obs;
  late final PacienteDbService db;

  @override
  void onInit() {
    super.onInit();
    db = Get.find<PacienteDbService>();
    cargarPacientes();
  }

  Future<void> cargarPacientes() async {
    final lista = await db.getAll();
    pacientes.assignAll(lista);
  }

  Future<void> agregarPaciente(String nombre, int edad, String diagnostico) async {
    final nuevo = Paciente(
      id: const Uuid().v4(),
      nombre: nombre,
      edad: edad,
      diagnostico: diagnostico,
    );
    await db.insert(nuevo);
    await cargarPacientes();
    Get.snackbar(
      'Éxito',
      'Paciente agregado correctamente',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.secondary,
      colorText: Get.theme.colorScheme.onSecondary,
    );
  }

  Future<void> editarPaciente(String id, String nombre, int edad, String diagnostico) async {
    final actualizado = Paciente(
      id: id,
      nombre: nombre,
      edad: edad,
      diagnostico: diagnostico,
    );
    await db.update(actualizado);
    await cargarPacientes();
    Get.snackbar(
      'Éxito',
      'Paciente actualizado correctamente',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.secondary,
      colorText: Get.theme.colorScheme.onSecondary,
    );
  }

  Future<void> eliminarPaciente(String id) async {
    await db.delete(id);
    await cargarPacientes();
    Get.snackbar(
      'Eliminado',
      'Paciente eliminado',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.secondary,
      colorText: Get.theme.colorScheme.onSecondary,
    );
  }
}
