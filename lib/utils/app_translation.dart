import 'package:get/get.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'es_EC': {
      'title': "Tareas",
      'new_task': 'Nueva Tarea',
      'add': 'Agregar',
      'no_task': 'Vacia la Lista',
      'confirm': 'Confirmar Eliminación',
      'description': 'Esta seguro de eliminar?',
      'acept': 'Aceptar',
    },
    'en_US': {
      'title': "Todo",
      'new_task': 'New Task',
      'add': 'Add',
      'no_task': 'Empty List',
      'confirm': 'Delete Confirm',
      'description': 'Are you sure delete?',
      'acept': 'Acept',
    },
  };
}
