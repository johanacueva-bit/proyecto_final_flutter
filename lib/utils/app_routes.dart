import 'package:get/get.dart';
import '../views/pacientes_view.dart';
import '../views/registro_paciente_view.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/',
      page: () => PacientesView(),
    ),
    GetPage(
      name: '/registro',
      page: () => RegistroPacienteView(),
    ),
  ];
}
