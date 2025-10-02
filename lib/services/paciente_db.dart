import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import '../models/paciente.dart';

class PacienteDbService extends GetxService {
  Future<void> printAllPacientes() async {
    final pacientes = await getAll();
    for (final p in pacientes) {
      print('Paciente: id=${p.id}, nombre=${p.nombre}, edad=${p.edad}, diagnostico=${p.diagnostico}');
    }
    if (pacientes.isEmpty) {
      print('No hay pacientes en la base de datos.');
    }
  }
  late Database db;

  Future<PacienteDbService> init() async {
    final dir = await getDatabasesPath();
    final path = p.join(dir, 'pacientes.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (d, v) async {
        await d.execute('''
          CREATE TABLE pacientes(
            id TEXT PRIMARY KEY,
            nombre TEXT NOT NULL,
            edad INTEGER NOT NULL,
            diagnostico TEXT NOT NULL
          );
        ''');
      },
    );
    return this;
  }

  Future<List<Paciente>> getAll() async {
    final rows = await db.query('pacientes', orderBy: 'nombre ASC');
    return rows.map((e) => Paciente.fromMap(e)).toList();
  }

  Future<void> insert(Paciente p) async {
    await db.insert('pacientes', p.toMap());
  }

  Future<void> update(Paciente p) async {
    await db.update('pacientes', p.toMap(), where: 'id = ?', whereArgs: [p.id]);
  }

  Future<void> delete(String id) async {
    await db.delete('pacientes', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    await db.close();
  }
}
